# yazi wrapper that changes cwd on exit
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

function fzf() {
  export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/fzfrc"

  if (($# > 0)) || [[ ! -t 0 ]]; then
    command fzf "$@"
    return
  fi

  local selected
  selected=$(command fzf --list-label="$PWD") || return

  if [[ -f "$selected" ]] && file --mime-type -b "$selected" | grep -q '^text/'; then
    vim "$selected"
  else
    yazi "$selected"
  fi
}

# rg wrapper that pipes search matches to fzf and opens selection in vim
function rgf() {
  (($# == 0)) && set -- .
  selected=$(rg --hidden --line-number --column --no-heading "$@" | fzf --list-label="$PWD") || return

  if [[ "$selected" =~ '^(.+):([0-9]+):([0-9]+):' ]]; then
    file="${match[1]}"
    line="${match[2]}"
    col="${match[3]}"
    vim "$file" "+call cursor(${line}, ${col})"
  fi
}

# tuicr wrapper that previews exported reviews with lightweight highlighting.
function tcr() {
  command tuicr --stdout "$@" | tee >(pbcopy) | _tuicr_prettify

  return "$pipestatus[1]"
}

function _tuicr_prettify() {
  local -a bat_args=(
    --language markdown
    --style=plain
    --paging=never
    --color=always
    --theme="$(system-appearance)"
  )

  command bat "${bat_args[@]}" | _tuicr_highlights
}

function _tuicr_highlights() {
  local red=$'\033[31m'
  local green=$'\033[32m'
  local yellow=$'\033[33m'
  local blue=$'\033[34m'

  local reset=$'\033[0m'
  local bold=$'\033[1m'
  local sep='(\033\[[0-9;:]*m)*'

  local -a labels=(
    "FIX:$red"
    "NOTE:$yellow"
    "QUESTION:$blue"
    "PRAISE:$green"
  )
  local -a highlight_args=()

  local item
  for item in "${labels[@]}"; do
    local label="${item%%:*}"
    local color="${item#*:}"
    local name="${label:l}"
    highlight_args+=(
      -v "${name}_pattern=${sep}[*][*]${sep}[[]${label}[]]${sep}[*][*]${sep}"
      -v "${name}_replacement=${bold}${color}**[${label}]**${reset}"
    )
  done

  awk "${highlight_args[@]}" '
    {
      gsub(fix_pattern, fix_replacement)
      gsub(note_pattern, note_replacement)
      gsub(question_pattern, question_replacement)
      gsub(praise_pattern, praise_replacement)
      print
    }
  '
}
