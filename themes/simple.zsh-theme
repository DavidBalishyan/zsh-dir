autoload -U colors && colors
setopt prompt_subst

git_prompt_info() {
  local ref dirty
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  [[ -n $ref ]] || return
  if ! git diff --quiet 2>/dev/null; then
    dirty="*"
  fi
  echo " %{$fg[cyan]%}git:(%{$fg[red]%}${ref}${dirty}%{$fg[cyan]%})%{$reset_color%}"
}


precmd() {
  if [[ -n $timer ]]; then
    local now=$EPOCHREALTIME
    local elapsed=$(printf "%.2f" "$(echo "$now - $timer" | bc)")
    LAST_CMD_TIME="$elapsed s"
    unset timer
  fi
}

build_prompt() {
  local git_status
  git_status=$(git_prompt_info)
  echo "%{$fg[green]%}%n@%m %{$fg[yellow]%}%~%{$reset_color%}${git_status} %{$fg_bold[blue]%}$ %{$reset_color%}"
}

build_rprompt() {
  local exit_code=$?
  local exit_display=""
  if [[ $exit_code -ne 0 ]]; then
    exit_display="%{$fg[red]%}✘ $exit_code%{$reset_color%}"
  fi

  local time_display=""
  if [[ -n $LAST_CMD_TIME ]]; then
    time_display="%{$fg[magenta]%}${LAST_CMD_TIME}%{$reset_color%}"
  fi

  echo "${exit_display} ${time_display}"
}

PROMPT='$(build_prompt)'
RPROMPT='$(build_rprompt)'

