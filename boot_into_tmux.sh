#!/bin/zsh
if ! tmux attach -t "Main"; then
    tmux new -s "Main"
fi
