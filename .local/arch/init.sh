#!/bin/bash -e

# Enable multilib & add extra repos {{{
sudo cp /etc/pacman.conf{,.bak}
sudo sed -i /etc/pacman.conf \
  -e 's/^#\(Color\)/\1\nILoveCandy/' \
  -e '/\[multilib\]/,/Include/s/^#//' \
  -e '$ a [quarry]\nServer = https://pkgbuild.com/~anatolik/quarry/x86_64/'
# }}}

# Update system and install basic packages {{{
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Syyu
sudo pacman -S base-devel git aria2 reflector go --noconfirm
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -sic --noconfirm)
git clone https://github.com/alfunx/dotfiles.sh \
  --single-branch --branch=sparse-edit /tmp/dotfiles.sh
(cd /tmp/dotfiles.sh && sudo make install)
# }}}

# Clone dotfiles {{{
mkdir -p ~/Documents/Code/GitHub
dotfiles clone https://github.com/ObserverOfTime/home.files \
  ~/Documents/Code/GitHub/home.files && dotfiles checkout -f
# }}}

# Rank pacman mirrors {{{
sudo cp /etc/pacman.d/mirrorlist{,.bak}
REF_OPTS=('--country GR' '--country DE' '--country FR'
          '--protocol https' '--protocol ftp' '--age 12'
          '--sort rate' '--save /etc/pacman.d/mirrorlist')
# shellcheck disable=SC2068
sudo reflector ${REF_OPTS[@]}
sudo mkdir -p /etc/pacman.d/hooks
sudo tee /etc/pacman.d/hooks/mirrorupgrade.hook >/dev/null <<EOF
[Trigger]
Operation = Upgrade
Type = Package
Target = pacman-mirrorlist

[Action]
Description = Updating pacman-mirrorlist with reflector
When = PostTransaction
Depends = reflector
Exec = /usr/bin/reflector ${REF_OPTS[*]}
EOF
unset REF_OPTS
# }}}

# Use aria2 for makepkg & set packager {{{
NAME="$(awk -F'[:,]' -vu="$USER" '$1 == u {print $5}' /etc/passwd)"
PACKAGER="${NAME:-ObserverOfTime} <chronobserver@disroot.org>"
ARIA='::/usr/bin/aria2c --conf-path=/etc/aria2.conf -o %o %u'
WGET="$(wget -V | awk 'NR == 1 {print $2"/"$3}')"
sudo tee /etc/aria2.conf >/dev/null <<EOF
user-agent=${WGET:-Wget}
summary-interval=0
file-allocation=none
split=4
EOF
sudo cp /etc/makepkg.conf{,.bak}
sudo sed -i /etc/makepkg.conf \
  -e "s#'ftp::.*'#'ftp$ARIA'#" \
  -e "s#'http::.*'#'http$ARIA'#" \
  -e "s#'https::.*'#'https$ARIA'#" \
  -e "s/^#PACKAGER.*/PACKAGER='$PACKAGER'/"
unset NAME PACKAGER ARIA WGET
# }}}

# Install packages via yay {{{
# shellcheck disable=SC2046,SC2086
_yay() (yay -S --$1 --needed ${*:2} $(<~/.local/arch/packages.$1.txt))
_yay repo --noconfirm && _yay aur
unset -f _yay
# }}}

# Install node packages {{{
yarn global install
# }}}

# Download binaries from github {{{
ghdl() (curl -L https://git.io/"$1" -o ~/.local/bin/"$2"; chmod +x "$_")
ghdl vhMor aria2magnet
ghdl fjlNS lnk-parse
unset -f ghdl
# }}}

# Install bash completions {{{
DIRECTORY="$XDG_DATA_HOME/bash-completion/completions"
declare -A ALIASES=(
  [adb]=android
  [emulator]=android
  [fastboot]=android
  [clang++]=clang
  [ffprobe]=ffmpeg
  [goapp]=go
  [godoc]=go
  [gradlew]=gradle
)
mkdir -p "$DIRECTORY"
raw() (printf 'https://raw.githubusercontent.com/%s' "$1/$2/master/$3")
aria2c -d "$DIRECTORY" -i - <<EOF
$(raw mbrubeck android-completion android)
$(raw clerk67 ffmpeg-completion ffmpeg)
$(raw gradle gradle-completion gradle-completion.bash)
  out=gradle
$(raw omakoto go-completion.bash go-completion.bash)
  out=go
$(raw llvm-mirror clang utils/bash-autocomplete.sh)
  out=clang
EOF
printf 'complete -o default -F _ffmpeg ffprobe\n' >> "$DIRECTORY/ffmpeg"
printf 'complete -o default -F _clang clang++\n' >> "$DIRECTORY/clang"
for key in "${!ALIASES[@]}"; do
  ln -fvs "$DIRECTORY/${ALIASES[$key]}" "$DIRECTORY/$key"
done
grunt --completion=bash > "$DIRECTORY/grunt"
gulp --completion=bash > "$DIRECTORY/gulp"
pandoc --bash-completion > "$DIRECTORY/pandoc"
poetry completions bash > "$DIRECTORY/poetry"
unset -f DIRECTORY ALIASES raw
# }}}

# Install from github reporisotories {{{
clone() { hub clone --depth=1 "$@" "/tmp/${1##*/}"; }

clone eli-schwartz/dotfiles.sh
(cd /tmp/dotfiles.sh && sudo make)

clone rkitover/vimpager
(cd /tmp/vimpager && sudo make PREFIX=/usr/local docs install)

clone ObserverOfTime/sddm-patema
sudo -E /tmp/sddm-patema/install.sh

# clone ObserverOfTime/PKGBUILDS
# TODO: wait for Jguer/yay#694
# }}}

# Configure grub {{{
THEME=/boot/grub/themes/Lain
SWAP="$(swapon --show=NAME --noheadings)"
SWAP="${SWAP+ resume=$SWAP}"
clone ObserverOfTime/grub2-theme-lain
sudo cp -r /tmp/grub2-theme-lain/Lain "$THEME"
sudo cp /etc/default/grub{,.bak}
sudo tee /etc/default/grub >/dev/null <<EOF
GRUB_DEFAULT=0
GRUB_TIMEOUT=10
GRUB_DISTRIBUTOR="Arch"
GRUB_CMDLINE_LINUX_DEFAULT="profile ipv6.disable=1${SWAP}"
GRUB_CMDLINE_LINUX=""
GRUB_TERMINAL_INPUT=console
GRUB_GFXMODE=1600x1200x24
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true
GRUB_DISABLE_SUBMENU=true
GRUB_THEME=$THEME/theme.txt
GRUB_FONT=$THEME/fonts/DejaVuSansMono14.pf2

# vim:set ft=cfg et sw=4 ts=4:
EOF
sudo cp /boot/grub/grub.cfg{,.bak}
sudo grub-mkconfig -o /boot/grub/grub.cfg
unset -f URL THEME SWAP clone
# }}}

# Setup neovim {{{
nvim --headless +q >/dev/null
nvim --headless +PlugInstall +qa >/dev/null
sudo update-alternatives --set editor /usr/bin/nvim
sudo tee --append /etc/sudoers <<< \
  'Defaults env_keep += "EDITOR"' >/dev/null
# }}}

# Setup mozilla profiles {{{
mkdir -p ~/.thunderbird ~/.mozilla/firefox
rclone sync -vv Mega:/Thunderbird \
  ~/.thunderbird/o8q08m34.default
cat > ~/.thunderbird/profiles.ini <<'EOF'
[Profile0]
Name=default
IsRelative=1
Path=o8q08m34.default
EOF
rclone sync -vv Mega:/Firefox \
  ~/.mozilla/firefox/6fgcqba8.dev-edition-default
cat > ~/.mozilla/firefox/profiles.ini <<'EOF'
[Profile0]
Name=dev-edition-default
IsRelative=1
Path=6fgcqba8.dev-edition-default
EOF
sudo tee /etc/pacman.d/hooks/firefox.hook >/dev/null <<EOF
[Trigger]
Operation = Upgrade
Type = File
Target = usr/bin/firefox-developer-edition

[Action]
Description = Setting GTK_USE_PORTAL=1 for Firefox...
When = PostTransaction
Exec = /bin/sed -i /usr/bin/firefox-developer-edition \
  -e 's/exec/GTK_USE_PORTAL=1 &/;s/"\$@"/-allow-downgrade &/'
EOF
# }}}

# Set tty font {{{
sudo tee /etc/vconsole.conf >/dev/null <<'EOF'
KEYMAP=us
FONT=ter-v18n
FONT_MAP=8859-2
EOF
sudo sed -i /etc/mkinitcpio.conf \
  -re 's/(^HOOKS="[^"]*)"/\1 consolefont"/'
sudo mkinitcpio -p linux
# }}}

# vim:fdm=marker:fdl=0:
