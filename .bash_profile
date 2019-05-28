# shellcheck disable=SC2155

# Print date on login
printf '\e[1m\e[91m%s \e[90m- \e[36m%s\e[m\n\n' \
  "$(date +%A,\ %B\ %e,\ %Y)" "$(date +%Z\ %:::z)"

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

# Set the default pager to vimpager
export PAGER=vimpager

# Set the default editor to neovim
export EDITOR=nvim

# Set the default browser to firefox
export BROWSER=firefox

# Set the android sdk directory
export ANDROID_HOME=~/.android/sdk/

# Set the path used by go
export GOPATH="$HOME/.local/go"

# Set the paths used by rubygems {{{
export GEM_HOME="$HOME/.local/ruby"
export GEM_SPEC_CACHE="$GEM_HOME/specs"
export GEM_PATH="$GEM_HOME:/usr/lib/ruby/gems/2.6.0"
# }}}

# Set the search path for commands
export PATH="$HOME/.local/bin:$PATH:$GOPATH/bin:$GEM_HOME/bin:$HOME/.yarn/bin"

# Use a 256color terminal if one exists {{{
for t in {konsole,xterm,gnome}-256color; do
  [ -f /usr/share/terminfo/${t:0:1}/$t ] && export TERM=$t && break
  [ $t == gnome-256color ] && export TERM=xterm
done
# }}}

# Source bashrc
test -f ~/.bashrc && source ~/.bashrc

# vim:set fdm=marker fdl=1:

