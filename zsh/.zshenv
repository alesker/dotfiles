get-password() {
  security find-generic-password -a "$USER" -s "$1" -w 2>/dev/null
}

export OPENAI_NEOVIM_MINUET_KEY="$(get-password OPENAI_NEOVIM_MINUET_KEY)"
