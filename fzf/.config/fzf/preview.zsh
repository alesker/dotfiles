#!/bin/zsh

local selected="$1"
local target="$selected"
local line

if [[ ! -e "$target" && "$selected" =~ '^(.+):([0-9]+):([0-9]+):' ]]; then
  target="${match[1]}"
  line="${match[2]}"
fi

if [[ -d "$target" ]]; then
  command eza --group-directories-first --color=always -la -- "$target"
elif [[ -f "$target" ]] && file --mime-type -b "$target" | grep -q '^text/'; then
  local -a bat_args=(--force-colorization --style=plain)

  if [[ -n "$line" ]]; then
    local start=$((line > 5 ? line - 5 : 1))
    bat_args+=(--highlight-line "$line" --line-range "$start:$((line + 10))")
  fi

  command bat "${bat_args[@]}" -- "$target"
elif [[ -e "$target" ]]; then
  command file -- "$target"
else
  print -r -- "$selected"
fi
