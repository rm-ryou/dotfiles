export ZDOTDIR="$HOME/.config/zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Overrides the value of the 'LANG' variable and the value of any of the other variables starting with 'LC_'.
export LC_ALL="en_US.UTF-8"

export EDITOR="vim"
export PAGER="less"
export LESS="-iR"

export TERM="xterm-256color"

# Language settings
# goenv
if [ -d "$HOME/.goenv" ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export GOENV_GOPATH_PREFIX="$HOME/.go"
  export GOPATH="${HOME}/.go"
  export PATH="$GOENV_ROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
  eval "$(goenv init - )"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export RBENV_ROOT="$HOME/.rbenv"
  export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init - zsh)"
fi
if [ -e "/opt/homebrew/opt/openssl@3" ]; then
  alias rbenv="RUBY_CONFIGURE_OPTS=--with-openssl-dir=/opt/homebrew/opt/openssl@3 rbenv"
fi

# volta
if [ -d "$HOME/.volta" ]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# Other tool settings
# fzf
if [ -d "$HOME/.fzf" ]; then
  export PATH="$HOME/.fzf/bin:$PATH"
fi

umask 022

