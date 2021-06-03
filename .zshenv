
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export PATH=$PATH:/home/cameron/bin:.
export PROMPT_COMMAND="echo -e '\e[?6c'"

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias grep='grep --color=auto'
alias ntop='bmon -p enp4s0'

alias vim='nvim'
alias vertex='ssh -p 6942 cameron@100.82.157.35' # Needs tailscale
alias euclid='ssh -p 6942 cameron@100.125.109.42'

alias pac='pacman'
alias pacs='pacman -Ss'
alias pacu='sudo pacman -Syyu'


alias gs='git status'
alias gl='git log'
alias glp='git log -p'

alias gcl='git clone'
alias gf='git fetch'

alias gb='git branch'
alias gch='git checkout'

alias gm='git merge'
alias gp='git pull'
alias gpu='git push'

alias gc='git commit'
alias gca='git commit --amend'

alias ga='git add'
alias gap='git add --patch'
alias grm='git rm'
alias gr='git restore'
alias grs='git restore --staged'

alias gst='git stash'

alias gd='git diff'
alias gdh='git diff HEAD'
alias gds='git diff --cached'

