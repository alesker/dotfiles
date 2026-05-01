# yazi wrapper that changes cwd on exit
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

#fzf wrapper that opens the selection either in vim or yazi
function fzo() {
  local selected
  selected=$(fzf "$@") || return

  if [[ -f "$selected" ]] && file --mime-type -b "$selected" | grep -q '^text/'; then
    vim "$selected"
  else
    yazi "$selected"
  fi
}

# rg wrapper that pipes search matches to fzf and opens selection in vim
function rgf() {
  selected=$(rg --hidden --line-number --column --no-heading "$@" | fzf) || return

  if [[ "$selected" =~ '^(.+):([0-9]+):([0-9]+):' ]]; then
    file="${match[1]}"
    line="${match[2]}"
    col="${match[3]}"
    vim "$file" "+call cursor(${line}, ${col})"
  fi
}
