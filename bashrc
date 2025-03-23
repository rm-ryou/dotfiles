###----- Basic Setting #### {{{
# Set vi mode
set -o vi

# time command's format configuration
TIMEFORMAT=$'\nreal\t%R\nuser\t%U\nsys\t%S\ncpu\t%P'

# History configurations
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/history"
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histverify

# Other options
# https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin
# https://www.gnu.org/software/bash/manual/bash.html#The-Shopt-Builtin
shopt autocd

# }}}
###----- Prompt -----#### {{{
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color';
fi;

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

  echo -e "${1}${branchName}${reset}${blue}${s}"
}

if tput setaf 1 &> /dev/null; then
  tput sgr0;  # reset colors
  bold=$(tput bold);
  reset=$(tput sgr0);
  black=$(tput setaf 0);
  green=$(tput setaf 2);
  blue=$(tput setaf 4);
  magenta=$(tput setaf 5);
  cyan=$(tput setaf 6);
  white=$(tput setaf 7)
fi;

PS1="\\n";                                                        # Add empty line
PS1+="\\[${bold}${blue}\\]\\u";                                   # User name
PS1+="\\[${reset}${white}\\] at \\[${bold}${cyan}\\]\\h";         # Host
PS1+="\\[${reset}${white}\\] in \\[${bold}${green}\\]\\w";        # Working directory
PS1+="\$(prompt_git \"${reset}${white} on ${bold}${magenta}\")";  # Git repository details
PS1+="\\n\\[${white}\\]\$ \\[${reset}\\]";
# }}}
###----- Aliases -----#### {{{

if $(command -v bat &>/dev/null); then
  alias cat="bat --color=always"
  export BAT_THEME="tokyonight_night"
fi

if $(command -v eza &>/dev/null); then
  alias ls="eza --color=always --icons=always"
  export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"
fi
# }}}
