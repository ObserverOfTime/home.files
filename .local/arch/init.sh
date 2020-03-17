#!/bin/bash -e

# Enable multilib & add extra repos {{{
sudo cp /etc/pacman.conf{,.bak}
sudo sed -i /etc/pacman.conf \
  -e 's/^#\(Color\)/\1\nILoveCandy/' \
  -e '/\[multilib\]/,/Include/s/^#//' \
  -e '$ a [quarry]\nServer = https://pkgbuild.com/~anatolik/quarry/x86_64/' \
  -e '$ a [chaotic-aur]\nServer = https://repo.kitsuna.net/x86_64/' \
  -e '$ a Server = http://lonewolf-builder.duckdns.org/chaotic-aur/x86_64/' \
  -e '$ a Server = http://chaotic.bangl.de/chaotic-aur/x86_64/'
# }}}

# Update system and install basic packages {{{
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --recv-keys 0x3056513887B78AEB
sudo pacman -Syyu --noconfirm
sudo pacman -S git aria2 reflector yay --noconfirm
# }}}

# Clone dotfiles {{{
(cd /tmp; yay -G dotfiles.sh-git)
pushd /tmp/dotfiles.sh-git >/dev/null
patch -n PKGBUILD <<'EOF'
12,13c12,14
< source=("${pkgname%-git}::git+$url")
< md5sums=("SKIP")
---
> source=("${pkgname%-git}::git+$url" "sparse-edit.patch::$url/pull/10.diff")
> md5sums=("SKIP" "6ecafcc0206a730aa40cc751435922ef")
> prepare() (git -C "$srcdir/${pkgname%-git}" apply "$srcdir/sparse-edit.patch")
EOF
makepkg -sic
popd >/dev/null
rm -r /tmp/dotfiles.sh-git
dotfiles clone https://github.com/ObserverOfTime/home.files \
  "${XDG_CONFIG_HOME:=$HOME/.config}/dotfiles"
dotfiles checkout --force
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
NAME="$(getent passwd "$USER" | awk -F'[:,]' '{print $5}')"
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
# shellcheck disable=SC2046
yay -S --repo --needed --noconfirm \
  $(<~/.local/arch/packages.repo.txt)
# shellcheck disable=SC2046
yay -S --aur --needed \
  $(<~/.local/arch/packages.aur.txt)
# }}}

# Download binaries from github {{{
mkdir -p ~/.local/bin
curl -LSs https://git.io/vhMor -o ~/.local/bin/aria2magnet
curl -LSs https://git.io/fjlNS -o ~/.local/bin/lnk-parse
chmod +x ~/.local/bin/{aria2magnet,lnk-parse}
# }}}

# Install bash completions {{{
DIRECTORY="${XDG_DATA_HOME:=.local/share}/bash/completions"
declare -A ALIASES=(
  [adb]=android
  [emulator]=android
  [fastboot]=android
  [clang++]=clang
  [ffprobe]=ffmpeg
  [goapp]=go
  [godoc]=go
  [gradlew]=gradle
  [bundler]=bundle
)
mkdir -p "$DIRECTORY"
aria2c -d "$DIRECTORY" -i - <<EOF
https://raw.githubusercontent.com/mbrubeck/android-completion/master/android
https://raw.githubusercontent.com/clerk67/ffmpeg-completion/master/ffmpeg
https://raw.githubusercontent.com/gradle/gradle-completion/master/gradle-completion.bash
  out=gradle
https://raw.githubusercontent.com/omakoto/go-completion.bash/master/go-completion.bash
  out=go
https://raw.githubusercontent.com/llvm-mirror/clang/master/utils/bash-autocomplete.sh
  out=clang
https://raw.githubusercontent.com/mernen/completion-ruby/master/completion-ruby
  out=ruby
https://raw.githubusercontent.com/mernen/completion-ruby/master/completion-gem
  out=gem
https://raw.githubusercontent.com/mernen/completion-ruby/master/completion-bundle
  out=bundle
https://raw.githubusercontent.com/mernen/completion-ruby/master/completion-rake
  out=rake
EOF
printf 'complete -o default -F _ffmpeg ffprobe\n' >> "$DIRECTORY/ffmpeg"
printf 'complete -o default -F _clang clang++\n' >> "$DIRECTORY/clang"
printf 'complete -o default -F __bundle bundler\n' >> "$DIRECTORY/bundle"
for key in "${!ALIASES[@]}"; do
  ln -fvs "$DIRECTORY/${ALIASES[$key]}" "$DIRECTORY/$key"
done
grunt --completion=bash > "$DIRECTORY/grunt"
gulp --completion=bash > "$DIRECTORY/gulp"
pandoc --bash-completion > "$DIRECTORY/pandoc"
poetry completions bash > "$DIRECTORY/poetry"
ln -fvs "$(gem contents travis | grep 'travis.sh$')" "$DIRECTORY/travis"
ln -fvs /usr/share/fzf/completion.bash "$DIRECTORY/fzf"
unset DIRECTORY ALIASES
# }}}

# Configure grub {{{
THEME=/boot/grub/themes/Lain
SWAP="$(swapon --show=NAME --noheadings)"
SWAP="${SWAP+ resume=$SWAP}"
git clone https://git.disroot.org/chronobserver/grub2-theme-lain \
  /tmp/grub2-theme-lain --depth=1
rm -rf /tmp/grub2-theme-lain/{.git*,README.md}
sudo cp -r /tmp/grub2-theme-lain "$THEME"
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

# vim:ft=cfg:
EOF
sudo cp /boot/grub/grub.cfg{,.bak}
sudo grub-mkconfig -o /boot/grub/grub.cfg
unset URL THEME SWAP
# }}}

# Configure SDDM {{{
git clone https://git.disroot.org/chronobserver/sddm-patema \
  /tmp/sddm-patema --depth=1
rm -rf /tmp/sddm-patema/{.git*,README.md}
sudo cp -r /tmp/sddm-patema /usr/share/sddm/themes/patema
sudo sed -i /etc/sddm.conf.d/kde_settings.conf \
  -e 's/^Current=.*$/Current=patema/'
# }}}

# Make maven use XDG_CACHE_HOME {{{
sudo sed -i /opt/maven/conf/settings.xml \
  -e "\%xsi:schema%a \\
  <localRepository>\\
    \${env.XDG_CACHE_HOME}/maven/repository\\
  </localRepository>"
# }}}

# Setup neovim {{{
nvim --headless +q >/dev/null
nvim --headless +PlugInstall +qa >/dev/null
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
sudo tee /etc/pacman.d/hooks/firefox.hook >/dev/null <<'EOF'
[Trigger]
Operation = Upgrade
Type = File
Target = usr/bin/firefox-developer-edition

[Action]
Description = Setting GTK_USE_PORTAL=1 for Firefox...
When = PostTransaction
Exec = /bin/sed -i /usr/bin/firefox-developer-edition \
  -e 's/exec/GTK_USE_PORTAL=1 &/;s/"$@"/-allow-downgrade &/'
EOF
# }}}

# Set user dirs {{{
xdg-user-dirs-update --set \
  TEMPLATES "$HOME/.local/templates"
xdg-user-dirs-update --set \
  PUBLICSHARE "$HOME/.local/public"
# }}}

# Set tty font {{{
sudo tee /etc/vconsole.conf >/dev/null <<'EOF'
KEYMAP=us
FONT=ter-v18n
FONT_MAP=8859-2
EOF
sudo sed -i /etc/mkinitcpio.conf \
  -re 's/(^HOOKS="[^"]*)"/\1 consolefont"/'
sudo mkinitcpio -p linux-zen
# }}}

# vim:fdm=marker:fdl=0:
