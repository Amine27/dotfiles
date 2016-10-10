alias tmux="tmux -2"
alias ta="tmux attach"
alias tt="tmux"
alias man="TERM=xterm LC_ALL= w3mman"
alias ls="ls --color=yes --group-directories-first"
alias ee="TERM=xterm-256color emacs -nw"
alias ec="TERM=xterm-256color emacsclient -t"
alias l1="ls -1"
alias ll="ls -lth"
alias la="ls -al"
alias gia='git add .'
alias gib='git branch -vv'
alias gic='git checkout'
alias gif='git fetch'
alias gig='git merge'
alias gil='git log --oneline --graph --all --decorate'
alias gill='git pull'
alias gim='git commit'
alias gip='git push'
alias gis='git status'
alias gid='git diff'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

if [ $BASH_VERSION ]; then
source ~/.git-completion.bash
__git_complete gia _git_add
__git_complete gic _git_checkout
__git_complete gil _git_log
__git_complete gill _git_pull
__git_complete gif _git_fetch
__git_complete gim _git_commit
__git_complete gip _git_push
__git_complete gid _git_diff
fi

psg () { ps aux | grep "$@" | grep -v grep; }
genpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;}

if [ $GDMSESSION ]; then
    if [ $GDMSESSION = "gnome" ]; then
	alias lkey="gsettings list-recursively org.gnome.desktop.wm.keybindings";
    fi
fi

export LESS=-iXFR
