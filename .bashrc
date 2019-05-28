# If not running interactively, don't do anything
[[ $- =~ i ]] || return

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"

# Define where cd looks for targets
[ -d ~/Documents/Code/GitHub ] && CDPATH='.:~/Documents/Code/GitHub'

__exit_code() {
  declare -i ECODE=$?
  if [[ $ECODE -ne 0 ]]; then
    printf '[\033[m\033[38;5;196m%s\033[0m]──' $ECODE
  fi
}

__parse_git() {
  declare BRANCH
  BRANCH="$(git symbolic-ref HEAD 2>/dev/null)"
  if [ -n "$BRANCH" ]; then
    if git status 2>/dev/null | grep -q 'nothing to commit'; then
      printf ' (%s)' "${BRANCH#refs/heads/}"
    else
      printf ' {%s}' "${BRANCH#refs/heads/}"
    fi
  fi
}

# Set the primary prompt string # shellcheck disable=SC1117
PS1="┌──[\[\e[m\]\[\033[38;5;12m\]\t\[\e[m\]\[\e[m\]]──\$(__exit_code)[\[\e[m\]\[\033[38;5;166m\]\u\[\e[m\]\[\e[m\]:\[\e[m\]\[\033[38;5;168m\]\w\[\e[m\]\[\e[m\]\[\033[38;5;150m\]\$(__parse_git)\[\e[m\]]\n└─➤ $ \[\e[m\]"

# Don't record some commands
HISTIGNORE='&:[ ]*:exit:ls:cd:history:clear'

# Remove old duplicate commands
HISTCONTROL='erasedups'

# Get the history file away from $HOME
HISTFILE="$HOME/.cache/.bash_history"

# Print time of command in history
HISTTIMEFORMAT='{%Y-%m-%d %T} '

# Automatically trim long paths in the prompt
PROMPT_DIRTRIM=3

# Don't complete files with the following extensions
FIGNORE='~:.o:.swp:.pyc'

# Alias definitions
test -f ~/.bash_aliases && . "$_"

# Travis completion
test -f ~/.travis/travis.sh && . "$_"

# FZF completion
test -f /usr/share/fzf/completion.bash && . "$_"

# Uni configuration
test -f ~/.unirc.sh && . "$_"

: # ensure 0 exit code

# vim:set wrap lbr bri briopt=shift\:4:

