# shellcheck shell=bash

# Define where cd looks for targets
[ -d "$HOME/Documents/Code" ] && CDPATH='.:~/Documents/Code'

# Set the primary prompt string
# shellcheck disable=SC2154
PS1='┌──[\[\e[m\]\[\033[38;5;12m\]\t\[\e[m\]\[\e[m\]]──$(test 0 -eq $? || printf "[\033[m\033[38;5;196m$_\033[0m]──")[\[\e[m\]\[\033[38;5;166m\]\u\[\e[m\]\[\e[m\]:\[\e[m\]\[\033[38;5;168m\]\w\[\e[m\]\[\e[m\]\[\033[38;5;150m\]$(b=$(git branch --show-current 2>/dev/null) && (git diff-index --quiet --ignore-submodules HEAD 2>/dev/null && printf " ($b)" || printf " {$b}"))\[\e[m\]]\n└─${DISPLAY+➤} \$ \[\e[m\]'

# Don't record some commands
HISTIGNORE='[ ]*:ls:ll:exit:logout:history:clear:bg:fg'

# Remove old duplicate commands
HISTCONTROL='erasedups'

# Move the history file away from $HOME
HISTFILE="$XDG_STATE_HOME/bash/history"

# Print time of command in history
HISTTIMEFORMAT='{%Y-%m-%d %T} '

# Automatically trim long paths in the prompt
PROMPT_DIRTRIM=2

# Don't complete files with the following extensions
FIGNORE='~:.o:.swp:.pyc'

# Show hints in ./configure --option=
# shellcheck disable=SC2034
COMP_CONFIGURE_HINTS=1

: # ensure 0 exit code

# vim:wrap:lbr:bri:briopt=shift\:4:
