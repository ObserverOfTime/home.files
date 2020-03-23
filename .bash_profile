# shellcheck disable=SC2183,SC2155

# Print date on login
printf '\e[1m\e[91m%(%A, %B %e, %Y)T \e[90m- \e[36m%(%Z %z)T\e[m\n\n'

# Include hidden files in glob
shopt -s dotglob

# Save multi-line commands as one command
shopt -s cmdhist

# Set the github & gitlab tokens {{{
test -f ~/.local/tokens/github && export GITHUB_TOKEN="$(<"$_")"
test -f ~/.local/tokens/gitlab && export GITLAB_TOKEN="$(<"$_")"
# }}}

# Set the default command used by fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore'

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

# Set the paths used by perl5 {{{
export PERL5LIB="$HOME/.local/perl/lib/perl5"
export PERL_CPANM_OPT="-l $HOME/.local/perl"
export PERL_CPANM_HOME="$HOME/.local/perl/.cpanm"
# }}}

# Set the paths used by rust {{{
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# }}}

# Set the paths used by node {{{
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/.node_repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# }}}

# Set the paths used by android {{{
export ANDROID_SDK_HOME="$HOME/.local/android"
export ANDROID_SDK_ROOT="$ANDROID_SDK_HOME"
export ANDROID_EMULATOR_HOME="$ANDROID_SDK_HOME"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
# }}}

# Set the paths used by sqlite {{{
export SQLITE_HISTORY="$XDG_CACHE_HOME/.sqlite_history"
# }}}

# Set the paths used by gtk {{{
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtkrc-2.0"
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

# Set the paths used by idea {{{
export IDEA_PROPERTIES="$XDG_CONFIG_HOME/intellij-idea/idea.properties"
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME/intellij-idea/idea.vmoptions"
# }}}

# Set the search path for commands {{{
export PATH="$HOME/.local/bin:\
/usr/bin:/usr/local/bin:/usr/sbin:\
/usr/lib/jvm/default/bin:\
/usr/bin/site_perl:\
/usr/bin/vendor_perl:\
/usr/bin/core_perl:\
$HOME/.local/perl/bin:\
$GOPATH/bin:\
$GEM_HOME/bin:\
$ANDROID_SDK_HOME/tools:\
$ANDROID_SDK_HOME/platform-tools:"
# }}}

# Use a 256color terminal if one exists {{{
for t in {konsole,xterm,gnome}-256color; do
  [ -f /usr/share/terminfo/${t:0:1}/$t ] && export TERM=$t && break
  [ $t == gnome-256color ] && export TERM=xterm
done
# }}}

# Specify inputrc
test -f "$XDG_CONFIG_HOME/inputrc" && export INPUTRC="$_"

# Specify xinitrc
test -f "$XDG_CONFIG_HOME/X11/xinitrc" && export XINITRC="$_"

# Source bashrc
test -f "$XDG_DATA_HOME/bash/bashrc.sh" && . "$_"

# vim:fdm=marker:fdl=1:
