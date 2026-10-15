get-password() {
  security find-generic-password -a "$USER" -s "$1" -w 2>/dev/null
}

export OPENAI_NEOVIM_MINUET_KEY="$(get-password OPENAI_NEOVIM_MINUET_KEY)"

# Noninteractive zsh and shell-launched editors also need runtime shims.
if [[ -x /opt/homebrew/bin/mise || -x /usr/local/bin/mise ]]; then
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi
