# Aliases {{{
# Go to parent directory
alias ..='cd ..'
# Copy from file to clipboard
alias fcopy='xclip -sel c -i'
# ffprobe without banner
alias ffprobe='ffprobe -hide_banner'
# ffmpeg without banner
alias ffmpeg='ffmpeg -hide_banner'
# Paste to file from clipboard
alias fpaste='xclip -sel -c -o > '
# fzf with preview
alias fzfp='fzf --preview "rougify --theme base16.monokai.dark {}"'
# git diff for regular files
alias gdiff='git diff --no-index'
# maximum 7z compression
alias ultra7z='7z a -t7z -m0=lzma2:d=1024m -mx=9 -md=32m -ms=on -mfb=64 -aoa'
# vimcat with gruvbox colorscheme
alias vcat='vimcat -c "colors gruvbox"'
# Use neovim instead of vim
alias vim='nvim'
# neovim terminal shell
alias vish='nvim +term'
# youtube-dl download as flac
alias ytdl-flac='youtube-dl -x --audio-format flac --audio-quality 9'
# youtube-dl download as mp3
alias ytdl-mp3='youtube-dl -x --audio-format mp3 --audio-quality 320K'
# maximum zip compression
alias zip-max='7z a -tzip -mm=Deflate -mx=9 -mfb=128 -mpass=10 -aoa'
# }}}

# Enable color support of commands {{{
if test -x /usr/bin/dircolors; then
  if test -r ~/.dir_colors; then eval "$(dircolors -b "$_")"
  else eval "$(dircolors -b)"; fi
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
# }}}

# ls aliases {{{
# -A: do not list implied . and ..
# -B: do not list implied entries ending with ~
# -F: append indicator (one of */=>@|) to entries
# -h: with -l and -s, print sizes like 1K 234M 2G etc.
# -H: follow symbolic links listed on the command line
# -l: use a long listing format
# -N: print entry names without quoting
# -1: list one file per line
alias ll='ls -lhAFH'
alias l1='ls -ANFH1'
alias l='ls -lhNFHB'
# }}}

# Add an alert function for long running commands {{{
alert() { # Use like so: sleep 10; alert
  # shellcheck disable=SC2181
  notify-send --urgency=low -i "$([ $? -eq 0 ] && printf terminal || printf error)" \
    "$(history | tail -1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"
}
# }}}

# Functions kept separately
test -f ~/.bash_funcs && . "$_"

# Secret ssh aliases
test -f ~/.ssh/aliases && . "$_"

# vim:set fdm=marker fdl=1:

