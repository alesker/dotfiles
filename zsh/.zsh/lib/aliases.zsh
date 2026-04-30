# Aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias md='mkdir -p'
alias rd=rmdir

alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'
alias lsa='ls -lah'

alias eza='eza --group-directories-first'
alias ls='eza'
alias ll='eza -lh'
alias la='eza -lAh --git'
alias lt='eza --tree --level=2 -A --git-ignore'
alias ltt='eza --tree --level=3 -A --git-ignore'
alias lttt='eza --tree --level=4 -A --git-ignore'

alias cat='bat'
alias vim='nvim'

alias da='date "+%A, %B %d, %Y [%T]"'
alias df='df -H'
alias du='du -c -h'
alias bc='bc -lqw'

