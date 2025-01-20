# shellcheck shell=bash disable=SC1090

# Print date on login
printf '\e[1m\e[91m%(%A, %B %d, %Y)T \e[90m- \e[36m%(%Z %z)T\e[m\n\n'

# Set shell options
shopt -s dotglob globstar cmdhist
shopt -u force_fignore

# Set the default pager
export PAGER='nvimpager'

# Set the default editor
export EDITOR='nvim'

# Set the default browser
export BROWSER='firefox'

# Set the default command & options used by skim {{{
export SKIM_DEFAULT_COMMAND='fd -LIH -tf --color=always'
export SKIM_CTRL_T_COMMAND='fd -LIH -tf'
export SKIM_ALT_C_COMMAND='fd -LIH -td'
export SKIM_DEFAULT_OPTIONS='--ansi'
# }}}

# Set the XDG directories {{{
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
# }}}

# Set the bash completion directory
export BASH_COMPLETION_USER_DIR="$XDG_DATA_HOME/bash"

# Specify the inputrc file
export INPUTRC="$XDG_CONFIG_HOME/inputrc"

# Source misc environment variables
test -f "$XDG_DATA_HOME/bash/environ.sh" && . "$_"

# Set the search path for commands {{{
export PATH="\
$HOME/.local/bin:\
/usr/local/bin:\
/usr/bin:\
/usr/lib/jvm/default/bin:\
/usr/lib/emscripten:\
/usr/bin/site_perl:\
/usr/bin/vendor_perl:\
/usr/bin/core_perl:\
$XDG_DATA_HOME/perl/bin:\
$XDG_DATA_HOME/npm/bin:\
$CARGO_HOME/bin:\
$GOPATH/bin"
# }}}

# Source bashrc
test -f "$XDG_DATA_HOME/bash/bashrc.sh" && . "$_"

# Source aliases
test -f "$XDG_DATA_HOME/bash/aliases.sh" && . "$_"

# Source functions
test -f "$XDG_DATA_HOME/bash/functions.sh" && . "$_"

# Source skim keybinds
test -f '/usr/share/skim/key-bindings.bash' && . "$_"

# vim:ft=sh:
