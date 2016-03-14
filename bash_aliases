alias aq="ash_query -q CWD"
alias tika="totxt"
alias ta="tmux attach"
alias tmux="tmux -2"
alias tt="tmux -2"
alias man="TERM=xterm LC_ALL= w3mman"
alias ls="ls --color=yes --group-directories-first"
#alias save="arecord --channels=2 --format=dat --vumeter=stereo `echo $(date +%Y_%m_%d_%H_%M_%S)`.wav"
alias em="emacsclient -t"
alias ee="TERM=xterm-256color emacs -nw"
alias ec="TERM=xterm-256color emacsclient -t"
alias apsch="aptitude search"
alias apsh="aptitude show"
alias uzbl="uzbl-tabbed"
alias attd="sudo aptitude"
alias apd="sudo aptitude"
alias vc="vncviewer 192.168.56.101"
alias dism="xmodmap -e \"keycode 135 = 0x0000\""
alias ensm="xmodmap -e \"keycode 135 = 0xff67\""
alias wls="nmcli dev wifi"
alias woff="nmcli nm wifi off"
alias won="nmcli nm wifi on"
alias wcls="nmcli -p con list"
alias catdoc="catdoc -w"
alias l1="ls -1"
alias ll="ls -lth"
alias la="ls -al"
alias gia='git add .'
alias gib='git branch -vv'
alias gic='git checkout'
alias gif='git fetch'
alias gig='git merge'
alias gil='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short --color'
alias gill='git pull'
alias gim='git commit'
alias gip='git push'
alias gis='git status'
alias gid='git diff'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
source ~/.git-completion.bash
__git_complete gia _git_add
__git_complete gic _git_checkout
__git_complete gil _git_log
__git_complete gill _git_pull
__git_complete gif _git_fetch
__git_complete gim _git_commit
__git_complete gip _git_push
__git_complete gid _git_diff
__git_complete gib _git_branch
