
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

export PATH=$PATH:/home/cameron/bin:.
export PROMPT_COMMAND="echo -e '\e[?6c'"

alias ls="ls --color=auto"
alias grep="grep --color=auto"


alias gs='git status'
alias gl='git log'
alias gld='git log -p'

alias gf='git fetch'

alias gm='git merge'
alias gp='git pull'
alias gpu='git push'

alias gc='git commit'
alias gca='git commit --amend'

alias ga='git add'
alias gap='git add --patch'
alias gr='git rm'
alias gu='git restore'
alias gus='git restore --staged'

alias gst='git stash'

alias gd='git diff'
alias gdh='git diff HEAD'
alias gds='git diff --cached'

