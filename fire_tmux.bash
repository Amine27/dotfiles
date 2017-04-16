if [ -z "$TMUX" ]; then
    tmux attach -t ssh_tmux || tmuxinator start ssh_tmux || tmux new -s ssh_tmux
fi
