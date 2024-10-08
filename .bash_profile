# shellcheck shell=bash disable=SC1090

# Print date on login
printf '\e[1m\e[91m%(%A, %B %d, %Y)T \e[90m- \e[36m%(%Z %z)T\e[m\n\n'

# Set shell options
shopt -s dotglob globstar cmdhist
shopt -u force_fignore

# Set the default command & options used by skim {{{
export SKIM_DEFAULT_COMMAND='fd -LIH -tf --color=always'
export SKIM_CTRL_T_COMMAND='fd -LIH -tf'
export SKIM_ALT_C_COMMAND='fd -LIH -td'
export SKIM_DEFAULT_OPTIONS='--ansi'
# }}}

# Set the default pager
export PAGER='nvimpager'

# Set the default editor
export EDITOR='nvim'

# Set the default browser
export BROWSER='firefox'

# Set the XDG directories {{{
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
# }}}

# Set the paths used by bash {{{
export BASH_COMPLETION_USER_DIR="$XDG_DATA_HOME/bash"
# }}}

# Set the paths used by python {{{
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/__pycache__"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc.py"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export PYLINTHOME="$XDG_STATE_HOME/pylint"
# }}}

# Set the paths used by go {{{
export GOPATH="$XDG_DATA_HOME/go"
# }}}

# Set the paths used by R {{{
export R_LIBS_USER="$XDG_DATA_HOME/R"
export R_PROFILE="$XDG_CONFIG_HOME/Rprofile"
export R_HISTFILE="$XDG_STATE_HOME/R/history"
# }}}

# Set the paths used by perl5 {{{
export PERL5LIB="$XDG_DATA_HOME/perl/lib/perl5"
export PERL_CPANM_OPT="-l $XDG_DATA_HOME/perl"
export PERL_CPANM_HOME="$XDG_DATA_HOME/perl/cpanm"
export PERL_LOCAL_LIB_ROOT="$HOME/.local/share/perl"
# }}}

# Set the paths used by rust {{{
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
# }}}

# Set the paths used by node {{{
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# }}}

# Set the paths used by android {{{
export ANDROID_HOME="$HOME/.local/android"
export ANDROID_USER_HOME="$ANDROID_HOME"
# }}}

# Set the paths used by kotlin {{{
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export KONAN_DATA_DIR="$XDG_DATA_HOME/konan"
# }}}

# Set the paths used by xorg {{{
export XCOMPOSEFILE="$XDG_CONFIG_HOME/X11/XCompose"
export XCOMPOSECACHE="$XDG_CACHE_HOME/X11/XCompose"
# }}}

# Set the paths used by ccache {{{
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.cfg"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
# }}}

# Set the paths used by gpg {{{
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
# }}}

# Set the paths used by docker {{{
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
# }}}

# Set the paths used by texlive  {{{
export TEXMFCONFIG="$XDG_CONFIG_HOME/texmf"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texmf"
# }}}

# Set the paths used by jetbrains {{{
export IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties"
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea.vmoptions"
export CLION_PROPERTIES="$XDG_CONFIG_HOME/clion/clion.properties"
export CLION_VM_OPTIONS="$XDG_CONFIG_HOME/clion/clion.vmoptions"
export PYCHARM_PROPERTIES="$XDG_CONFIG_HOME/pycharm/charm.properties"
export PYCHARM_VM_OPTIONS="$XDG_CONFIG_HOME/pycharm/charm.vmoptions"
# }}}

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

# Specify inputrc
test -f "$XDG_CONFIG_HOME/inputrc" && export INPUTRC="$_"

# Source skim keybinds
test -f '/usr/share/skim/key-bindings.bash' && . "$_"

# Source bashrc
test -f "$XDG_DATA_HOME/bash/bashrc.sh" && . "$_"

# Source aliases
test -f "$XDG_DATA_HOME/bash/aliases.sh" && . "$_"

# Source functions
test -f "$XDG_DATA_HOME/bash/functions.sh" && . "$_"

# vim:fdm=marker:fdl=1:ft=sh:
