if [ -z "$TMUX" ]; then
    tmux attach || tmuxinator start ssh_tmux || tmux new -s ssh_tmux
fi
