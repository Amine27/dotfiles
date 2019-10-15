if [ -z "$TMUX" ]; then
    tmux attach || tmuxinator start $(tmuxinator ls | tail -n1) || tmux new -s ssh_tmux
fi
