# Bash reference manual
# https://www.gnu.org/software/bash/manual/bash.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export LC_ALL="en_US.UTF-8"

export EDITOR="vim"
export PAGER="less"
export LESS="-iR"

export TERM="xterm-256color"

# Set path so it includes user's private bin
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Language settings
# goenv
if [ -d "$HOME/.goenv" ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export GOENV_GOPATH_PREFIX="$HOME/.go"
  export GOPATH="$HOME/.go"
  export PATH="$GOENV_ROOT/bin:$PATH"
  export PATH="PATH:$GOPATH/bin"
  eval "$(goenv init - )"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - bash)"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export RBENV_ROOT="$HOME/.rbenv"
  export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init - )")
fi
if [ -e "/opt/homebrew/opt/openssl@3" ]; then
  alias="RUBY_CONFIGURE_OPTS=--with-openssl-dir=/opt/homebrew/opt/openssl@3 rbenv"
fi

# volta
if [ -d "$HOME/.volta" ]; then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# Other tool settings
# fzf
[ -f "$HOME/.fzf.bash" ] && \. "$HOME/.fzf.bash"

umask 022

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;33m") \
    LESS_TERMCAP_md=$(printf "\e[1;33m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Invoked as an interactive non-login shell
if [ -f "$HOME/.bashrc" ]; then . "$HOME/.bashrc"; fi
