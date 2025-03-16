export PATH="$HOME/.local/bin:$PATH"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

if $(command -v brew &>/dev/null); then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
