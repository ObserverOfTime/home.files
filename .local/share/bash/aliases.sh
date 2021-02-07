# Aliases {{{
# go to parent directory
alias ..='cd ..'
# go to previous directory
alias -- -='cd -'
# R without save prompt
alias R='R -q --no-save'
# copy from file to clipboard
alias fcopy='xclip -sel c -i'
# ffprobe without banner
alias ffprobe='ffprobe -hide_banner'
# ffmpeg without banner
alias ffmpeg='ffmpeg -hide_banner'
# paste to file from clipboard
alias fpaste='xclip -sel c -o > '
# fzf with preview
alias fzfp='fzf --preview rougify\ -tbase16.dark\ {}'
# git diff for regular files
alias gdiff='git diff --no-index'
# print makefile variable
alias pmake="make --eval='print-%: ; @echo $'$'*=$'$'($'$'*)'"
# maximum 7z compression
alias ultra7z='7z a -t7z -m0=lzma2:d=1024m -mx=9 -md=32m -ms=on -mfb=64 -aoa'
# activate virtualenv
alias venv='. .venv/bin/activate'
# neovim terminal shell
alias vish='SHELL=/bin/bash\ -l nvim +term'
# maximum zip compression
alias zip-max='7z a -tzip -mm=Deflate -mx=9 -mfb=128 -mpass=10 -aoa'
# }}}

# Enable color support of commands {{{
if test -r "$XDG_CONFIG_HOME/dircolors"; then
  eval "$(dircolors -b "$_")"
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

# Alert for long running commands {{{
alert() { # Use like so: sleep 10; alert
  # shellcheck disable=SC2181
  notify-send -u low -i "$( (($?)) && printf error || printf terminal)" \
    "$(history | sed -e '$!d;s/^[^}]\+}\s*//;s/[;&|]\s*alert$//')"
}
# }}}

# vim:fdm=marker:fdl=1:
