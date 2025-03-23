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

  echo -e "${1}${branchName}${2}${s}"
}

if tput setaf 1 &> /dev/null; then
  tput sgr0;    # reset colors
  bold=$(tput bold);
  reset=$(tput sgr0);
  black=$(tput setaf 0);
  green=$(tput setaf 2);
  blue=$(tput setaf 4);
  magenta=$(tput setaf 5);
  cyan=$(tput setaf 6);
  white=$(tput setaf 7)
fi;

PS1="\\[${bold}\\]\\n";                           # Add empty line
PS1+="\\[${bold}${blue}\\]\\u";                   # User name
PS1+="\\[${white}\\] at \\[${bold}${cyan}\\]\\h"; # Host
PS1+="\\[${white}\\] in \\[${green}\\]\\w";       # Working directory
PS1+="\$(prompt_git \"${white} on ${magenta}\")"; # Git repository details
PS1+="\\n\\[${white}\\]\$ \\[${reset}\\]";
# }}}
