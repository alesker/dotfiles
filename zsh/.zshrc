export ZSH="$HOME/.zsh"

export EDITOR='nvim'
export VISUAL="$EDITOR"

export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"


autoload -U colors && colors
PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} "

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load "$HOME/.zsh_plugins"

for lib_file ("$ZSH"/lib/*.zsh); do
  source "$lib_file"
done
unset lib_file

source <(fzf --zsh)

source $(brew --prefix)/share/chruby/chruby.sh
source $(brew --prefix)/share/chruby/auto.sh


if [ -f ~/.custom-zshrc ]; then
  source ~/.custom-zshrc
fi


if type fastfetch &>/dev/null; then
  fastfetch
fi


eval "$(zoxide init zsh --cmd cd)"

export STARSHIP_CONFIG=~/.config/starship-pills.toml
eval "$(starship init zsh)"
