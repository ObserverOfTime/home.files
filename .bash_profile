#!/bin/bash

# Print date on login
printf '\e[1m\e[91m%(%A, %B %d, %Y)T \e[90m- \e[36m%(%Z %z)T\e[m\n\n'

# Set shell options
shopt -s dotglob globstar cmdhist
shopt -u force_fignore

# Set the default command & options used by fzf {{{
export FZF_DEFAULT_COMMAND='fd -LIH -tf --color=always'
export FZF_CTRL_T_COMMAND='fd -LIH -tf'
export FZF_ALT_C_COMMAND='fd -LIH -td'
export FZF_DEFAULT_OPTS='--ansi'
# }}}

# Set the default pager
export PAGER='nvimpager -p'

# Set the default editor
export EDITOR=nvim

# Set the default browser
export BROWSER=firefox

# Set the XDG directories {{{
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
# }}}

# Set the paths used by bash {{{
export BASH_COMPLETION_USER_DIR="$XDG_DATA_HOME/bash"
# }}}

# Set the paths used by python {{{
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/__pycache__"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc.py"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
# }}}

# Set the paths used by go {{{
export GOPATH="$HOME/.local/go"
# }}}

# Set the paths used by ruby {{{
export GEM_HOME="$HOME/.local/ruby"
export GEM_SPEC_CACHE="$GEM_HOME/specs"
export GEM_PATH="$GEM_HOME:/usr/lib/ruby/gems/2.7.0"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export TRAVIS_CONFIG_PATH="$XDG_CONFIG_HOME/travis"
# }}}

# Set the paths used by R {{{
export R_LIBS_USER="$HOME/.local/R"
export R_PROFILE="$XDG_CONFIG_HOME/Rprofile"
export R_HISTFILE="$XDG_CACHE_HOME/.R_history"
# }}}

# Set the paths used by perl5 {{{
export PERL5LIB="$HOME/.local/perl/lib/perl5"
export PERL_CPANM_OPT="-l $HOME/.local/perl"
export PERL_CPANM_HOME="$HOME/.local/perl/.cpanm"
# }}}

# Set the paths used by rust {{{
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
# }}}

# Set the paths used by node {{{
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/.node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# }}}

# Set the paths used by android {{{
export ANDROID_HOME="$HOME/.local/android"
export ANDROID_SDK_HOME="$ANDROID_HOME"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_AVD_HOME="$ANDROID_HOME/avd"
export ANDROID_EMULATOR_HOME="$ANDROID_HOME"
# }}}

# Set the paths used by kotlin {{{
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export KONAN_DATA_DIR="$XDG_DATA_HOME/konan"
# }}}

# Set the paths used by sqlite {{{
export SQLITE_HISTORY="$XDG_CACHE_HOME/.sqlite_history"
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
# }}

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
export PATH="$HOME/.local/bin:\
/usr/local/bin:/usr/bin:\
/usr/lib/jvm/default/bin:\
/usr/bin/site_perl:\
/usr/bin/vendor_perl:\
/usr/bin/core_perl:\
$HOME/.local/perl/bin:\
$GOPATH/bin:\
$GEM_HOME/bin"
# }}}

# Use a 256color terminal if one exists {{{
for t in {konsole,xterm,gnome}-256color; do
  [ -f /usr/share/terminfo/${t:0:1}/$t ] && export TERM=$t && break
  [ $t == gnome-256color ] && export TERM=xterm
done
unset t
# }}}

# Specify inputrc
test -f "$XDG_CONFIG_HOME/inputrc" && export INPUTRC="$_"

# Source fzf keybinds
test -f /usr/share/fzf/key-bindings.bash && . "$_"

# Source github & gitlab tokens {{{
test -f "$XDG_DATA_HOME/tokens" && . "$_"
# }}}

# Source bashrc
test -f "$XDG_DATA_HOME/bash/bashrc.sh" && . "$_"

# Source aliases
test -f "$XDG_DATA_HOME/bash/aliases.sh" && . "$_"

# Source functions
test -f "$XDG_DATA_HOME/bash/functions.sh" && . "$_"

# vim:fdm=marker:fdl=1:
