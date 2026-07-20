# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=default,bold,underline'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=default,bold,underline'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_PREFIXED=1

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

setopt GLOB_DOTS
