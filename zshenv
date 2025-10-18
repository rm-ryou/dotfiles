export ZDOTDIR="${HOME}/.config/zsh"

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

# brew
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# mise
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
  export GOBIN="${HOME}/.go/bin"
fi

# Other tool settings
# fzf
if [ -d "$HOME/.fzf" ]; then
  export PATH="$HOME/.fzf/bin:$PATH"
fi

umask 022
