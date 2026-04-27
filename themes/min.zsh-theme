autoload -U colors && colors
setopt PROMPT_SUBST

prompt_dir() {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%F{cyan}$%f"
  else
    echo "%F{blue}%~%f %F{cyan}$%f"
  fi
}

PROMPT='$(prompt_dir) '
