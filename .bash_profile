# shellcheck disable=SC2183,SC2155

# Print date on login
printf '\e[1m\e[91m%(%A, %B %e, %Y)T \e[90m- \e[36m%(%Z %z)T\e[m\n\n'

# Ctrl + Space to expand command
bind '\C-Space':magic-space

# Case insensitive completion
bind 'set completion-ignore-case on'

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

# Set the paths used by python {{{
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/__pycache__"
# }}}

# Set the paths used by go {{{
export GOPATH="$HOME/.local/go"
# }}}

# Set the paths used by ruby {{{
export GEM_HOME="$HOME/.local/ruby"
export GEM_SPEC_CACHE="$GEM_HOME/specs"
export GEM_PATH="$GEM_HOME:/usr/lib/ruby/gems/2.6.0"
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

# Set the paths used by the android sdk {{{
export ANDROID_HOME="$HOME/.local/android"
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
$ANDROID_HOME/tools:\
$ANDROID_HOME/platform-tools:"
# }}}

# Set the paths used by ccache {{{
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.cfg"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
# }}}

# Use a 256color terminal if one exists {{{
for t in {konsole,xterm,gnome}-256color; do
  [ -f /usr/share/terminfo/${t:0:1}/$t ] && export TERM=$t && break
  [ $t == gnome-256color ] && export TERM=xterm
done
# }}}

# Source bashrc
test -f ~/.bashrc && source ~/.bashrc

# vim:set fdm=marker fdl=1:
