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

alias cat='bat'
alias vim='nvim'

alias da='date "+%A, %B %d, %Y [%T]"'
alias df='df -H'
alias du='du -c -h'
alias bc='bc -lqw'

alias rgf='() { rg $@ | fzf }'
