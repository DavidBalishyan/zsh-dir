# Enable colors
autoload -U colors && colors
setopt prompt_subst

# --- Git prompt function ---
git_prompt_info() {
  # Get current branch or commit short hash
  local ref dirty
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [[ -n $ref ]] || return  # not a git repo

  # Check if working tree is dirty
  if ! git diff --quiet 2>/dev/null; then
    dirty="✗"
  fi

  # Print formatted git info
  if [[ -n $dirty ]]; then
    echo " %{$fg_bold[blue]%}git:(%{$fg[red]%}${ref}%{$fg_bold[blue]%}) %{$fg[yellow]%}${dirty}%{$reset_color%}"
  else
    echo " %{$fg_bold[blue]%}git:(%{$fg[red]%}${ref}%{$fg_bold[blue]%})%{$reset_color%}"
  fi
}

# --- Prompt ---
PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%}$(git_prompt_info) '

