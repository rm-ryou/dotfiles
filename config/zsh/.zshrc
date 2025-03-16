###----- Basic Setting #### {{{
# Set vi mode
bindkey -v
export KEYTIMEOUT=1

# time command's format configuration
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# Hide EOL sign ('%')
PROMPT_EOL_MARK=""

# History configurations
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE=1000
SAVEHIST=2000
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_VERIFY            # show command with history expansion to user before running it

# Zsh syntax highlighting
if [ -f "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Zsh auto suggestions
if [ -f "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Other options
# https://zsh.sourceforge.io/Doc/Release/Options.html#Options
setopt AUTO_CD              # Change directory just by typing its name
setopt CORRECT              # Auto correct mistake
setopt IGNORE_EOF           # Do not exit on end-of-file
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shells
setopt NONOMATCH            # Hide error msg if there is no match for the pattern
setopt NOTIFY               # Report the status of background jobs immediately
setopt NUMERIC_GLOB_SORT    # Sort filenames numerically when it makes sense
# }}}
###----- Prompt -----#### {{{
# Enable command substitution in prompt
setopt PROMPT_SUBST

prompt_git() {
  local s="";
  local branchName="";

  # Check if the current directory is in a Git repository.
  git rev-parse --is-inside-work-tree &>/dev/null || return
  branchName=$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
    git rev-parse --short HEAD 2> /dev/null || \
    echo "(unknown)")

  # Check for uncommitted change in the index.
  if ! git diff --quiet --ignore-submodules --cached; then
    s+="+"
  fi
  # Check for unstaged changes.
  if ! git diff-files --quiet --ignore-submodules --; then
    s+="!"
  fi
  # Check for untracked files.
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    s+="?"
  fi
  # Check for stashed files.
  if git rev-parse --verify refs/stash &>/dev/null; then
    s+="$"
  fi

  [ -n "${s}" ] && s=" [${s}]"

  echo -E "${1}${branchName}${2}${s}"
}

# Set the terminal title and prompt.
precmd() {
  PROMPT=$'\n'                                                  # Add empty line
  PROMPT+='%B%F{blue}%n%f%b'                                    # User name
  PROMPT+='%F{white} at%f %B%F{cyan}%m%f%b'                     # Host
  PROMPT+='%F{white} in%f %B%F{green}%~%f%b'                    # Working directory
  PROMPT+=$(prompt_git '%F{white} on%f %F{magenta}' '%F{blue}') # Git repository details
  PROMPT+=$'\n%F{white}$%f '
}
# }}}
###----- Completion -----#### {{{
# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Allow to select in a menu
zstyle ':completion:*' menu select
# Include hidden files
_comp_options+=(globdots)

zstyle ':completion:*:*:git:*' script "$ZDOTDIR/completions/git-completion.bash"

# Load more completions
fpath=($ZDOTDIR/completions $fpath)
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# Should be called before compinit
zmodload zsh/complist

# Enable auto/tab complete
autoload -U compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
# }}}
###----- ZLE -----#### {{{
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Zsh-Line-Editor
# vim key bind in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape by vi mode
function zle-keymap-select () {
  case $KEYMAP in
    vicmd)              # When normal mode
      echo -ne '\e[2 q' # Smple block
      ;;
    viins|main)         # When insert mode
      echo -ne '\e[6 q' # Simple beam
      ;;
  esac
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  echo -ne "\e[6 q"
}
zle -N zle-line-init
# Set beam shape cursor for each new prompt
preexec() { echo -ne '\e[6 q' ;}

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# }}}
###----- Aliases -----#### {{{
# force zsh to show the complete history
alias history="history 0"

if $(command -v bat &>/dev/null); then
  alias cat="bat --color=always"
  export BAT_THEME="tokyonight_night"
fi

if $(command -v eza &>/dev/null); then
  alias ls="eza --color=always --icons=always"
  export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"
fi
# }}}
###----- Tools Setting -----#### {{{
### FZF {{{
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

show_preview="if [ -d {} ]; then eza --tree --color=always {}; else bat --color=always {}; fi"
# NOTE It is not recommended to put ANSI and PREVIEW in FZF_DEFAULT_OPTS.
# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="
  --ansi
  --border=none
  --highlight-line
  --info=inline-right
  --layout=reverse
  --preview '$show_preview'
  --color=fg:#c0caf5,bg:#16161e,hl:#2ac3de
  --color=fg+:#c0caf5,bg+:#283457,hl+:#2ac3de
  --color=gutter:#16161e,info:#545c7e
  --color=border:#27a1b9,prompt:#2ac3de
  --color=pointer:#ff007c,marker:#ff007c
  --color=spinner:#ff007c,header:#ff9e64
  --color=scrollbar:#27a1b9,separator:#ff9e64
  --color=query:#c0caf5:regular"
export FZF_CTRL_R_OPTS="--no-sort --exact"
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target"
# }}}
# }}}
