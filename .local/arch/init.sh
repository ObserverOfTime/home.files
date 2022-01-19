#!/bin/bash -e

# Enable multilib & add extra repos {{{
sudo cp /etc/pacman.conf{,.bak}
sudo sed -i /etc/pacman.conf \
  -e 's/^#\(Color\)/\1\nILoveCandy/' \
  -e '/\[multilib\]/,/Include/s/^#//' \
  -e '$ a \n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist'
# }}}

# Update system and install basic packages {{{
CHAOTIC='https://cdn-mirror.chaotic.cx/chaotic-aur'
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
sudo pacman -U "$CHAOTIC"/chaotic-{keyring,mirrorlist}.pkg.tar.zst
sudo pacman -Syyu --noconfirm
sudo pacman -S git aria2 yay --noconfirm
unset CHAOTIC
# }}}

# Clone dotfiles {{{
git clone https://git.disroot.org/PKGBUILDS/dotfiles-alfunx-git \
  /tmp/dotfiles-alfunx-git --depth=1
(cd /tmp/dotfiles-alfunx-git; makepkg -sic)
rm -rf /tmp/dotfiles-alfunx-git
dotfiles clone https://github.com/ObserverOfTime/home.files \
  "${XDG_DATA_HOME:=$HOME/.local/share}/dotfiles"
dotfiles checkout --force
dotfiles submodule update --init
# }}}

# Use aria2 for makepkg & set packager {{{
NAME="$(getent passwd "$USER" | awk -F'[:,]' '{print $5}')"
PACKAGER="${NAME:=ObserverOfTime} <chronobserver@disroot.org>"
ARIA='/usr/bin/aria2c --conf-path=/etc/aria2.conf -o %o %u'
sudo tee /etc/aria2.conf >/dev/null <<EOF
summary-interval=0
file-allocation=none
split=4
continue=true
follow-metalink=mem
metalink-location=gr,de,us,fr,it
metalink-preferred-protocol=https
EOF
sudo cp /etc/makepkg.conf{,.bak}
sudo sed -i /etc/makepkg.conf \
  -e "s#'ftp::.*'#'ftp::$ARIA'#" \
  -e "s#'http::.*'#'http::$ARIA'#" \
  -e "s#'https::.*'#'https::$ARIA'#" \
  -e "s/^#PACKAGER.*/PACKAGER='$PACKAGER'/"
unset NAME PACKAGER ARIA
# }}}

# Disable wine file associations {{{
sudo tee /etc/pacman.d/hooks/wine.hook >/dev/null <<EOF
[Trigger]
Operation = Install
Operation = Upgrade
Type = File
Target = usr/share/wine/wine.inf

[Action]
Description = Disabling wine menu builder...
When = PostTransaction
Exec = /bin/sed -i /usr/share/wine/wine.inf \
  -e 's/winemenubuilder.exe -a -r/winemenubuilder.exe -r/'
EOF
# }}}

# Disable netrw file explorer {{{
sudo tee /etc/pacman.d/hooks/netrw.hook >/dev/null <<EOF
[Trigger]
Operation = Install
Operation = Upgrade
Type = Path
Target = usr/share/nvim/runtime/plugin/netrwPlugin.vim

[Action]
Description = Disabling netrw file explorer...
When = PostTransaction
Exec = /bin/sed -e '/FileExplorer/,/END/d' -i \
  /usr/share/nvim/runtime/plugin/netrwPlugin.vim
EOF
# }}}

# Install packages via yay {{{
xargs <~/.local/arch/packages.repo.txt \
  yay -S --repo --needed --noconfirm
xargs <~/.local/arch/packages.aur.txt \
  yay -S --aur --needed --noconfirm
# }}}

# Install bash completions {{{
DIRECTORY="${XDG_DATA_HOME:=$HOME/.local/share}/bash/completions"
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
aria2c -d "$DIRECTORY" -i - <<EOF
https://raw.githubusercontent.com/mbrubeck/android-completion/master/android
https://raw.githubusercontent.com/clerk67/ffmpeg-completion/master/ffmpeg
https://raw.githubusercontent.com/gradle/gradle-completion/master/gradle-completion.bash
  out=gradle
https://raw.githubusercontent.com/omakoto/go-completion.bash/master/go-completion.bash
  out=go
https://raw.githubusercontent.com/llvm-mirror/clang/master/utils/bash-autocomplete.sh
  out=clang
EOF
printf '\ncomplete -o default -F _ffmpeg ffprobe\n' >> "$DIRECTORY/ffmpeg"
printf '\ncomplete -o default -F _clang clang++\n' >> "$DIRECTORY/clang"
for key in "${!ALIASES[@]}"; do
  ln -fvs "$DIRECTORY/${ALIASES[$key]}" "$DIRECTORY/$key"
done
pandoc --bash-completion > "$DIRECTORY/pandoc"
poetry completions bash > "$DIRECTORY/poetry"
ln -fvs /usr/share/fzf/completion.bash "$DIRECTORY/fzf"
unset DIRECTORY ALIASES
# }}}

# Configure grub {{{
THEME=/boot/grub/themes/Lain
git clone https://git.disroot.org/chronobserver/grub2-theme-lain \
  /tmp/grub2-theme-lain --depth=1
rm -rf /tmp/grub2-theme-lain/{.git*,README.md}
sudo cp -r /tmp/grub2-theme-lain "$THEME"
sudo cp /etc/default/grub{,.bak}
sudo tee /etc/default/grub >/dev/null <<EOF
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="Arch"
GRUB_CMDLINE_LINUX_DEFAULT="profile ipv6.disable=1"
GRUB_CMDLINE_LINUX=""
GRUB_TERMINAL_INPUT=console
GRUB_GFXMODE=1600x1200x24
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_SUBMENU=true
GRUB_THEME=$THEME/theme.txt

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
sudo mkdir -p /etc/sddm.conf.d
sudo tee "$_/theme.conf" >/dev/null <<< $'[Theme]\nCurrent=patema'
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
sudo ln -s /usr/bin/nvim /usr/local/bin/vi
sudo ln -s /usr/bin/nvim /usr/local/bin/vim
# }}}

# Create wrapper scripts {{{
sudo tee /usr/local/bin/jarwrapper >/dev/null <<'EOF'
#!/bin/sh

exec "${JAVA_HOME:-/usr/lib/jvm/default}/bin/java" -jar "$@"
EOF
sudo tee /usr/local/bin/sqlite3 >/dev/null <<'EOF'
#!/bin/sh

exec env \
  SQLITE_HISTORY="${XDG_CACHE_HOME:-$HOME}/.sqlite_history" \
  /usr/bin/sqlite3 "$@"
EOF
sudo tee /usr/local/bin/wget >/dev/null <<'EOF'
#!/bin/sh

exec /usr/bin/wget "$@" \
  --hsts-file="${XDG_CACHE_HOME:-$HOME}/.wget-hsts"
EOF
sudo chmod +x /usr/local/bin/{jarwrapper,sqlite3,wget}
# }}}

# Configure binfmt {{{
sudo tee /etc/binfmt.d/jar.conf >/dev/null \
  <<< ':JAR:E::jar::/usr/local/bin/jarwrapper:'
sudo ln -s /etc/binfmt.d/wine.conf /dev/null
# }}}

# Set user dirs {{{
mkdir -p "$HOME"/.local/{templates,public}
xdg-user-dirs-update --set TEMPLATES "$HOME/.local/templates"
xdg-user-dirs-update --set PUBLICSHARE "$HOME/.local/public"
# }}}

# Set tty font {{{
sudo tee /etc/vconsole.conf >/dev/null <<'EOF'
KEYMAP=us
FONT=ter-v22n
FONT_MAP=8859-2
EOF
sudo sed -i /etc/mkinitcpio.conf \
  -re 's/(^HOOKS="[^"]*)"/\1 consolefont"/'
sudo mkinitcpio -p linux-tkg-pds
# }}}

# vim:fdm=marker:fdl=0:
