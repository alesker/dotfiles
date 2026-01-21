#!/usr/bin/env bash

op account get >/dev/null

SECRETS=(
  "OPENAI_NEOVIM_MINUET_KEY|OpenAI API/neovim-minuet"
)

for item in "${SECRETS[@]}"; do
  key="${item%%|*}"
  value="${item#*|}"

  secret="$(op read "op://Personal/$value")"

  security add-generic-password \
    -a "$USER" \
    -s "$key" \
    -w "$secret" \
    -U \
    >/dev/null
  echo "Keychained: $key"
done

echo "Finished bootstrapping secrets."
