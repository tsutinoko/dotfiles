#!/bin/sh

DIR_NAME=$(cd $(dirname $0) && pwd)

ln -sf $DIR_NAME/.vimrc ~/.vimrc
ln -sf $DIR_NAME/.zsh ~/.zsh
ln -sf $DIR_NAME/.zsh/.zshrc ~/.zshrc
ln -sf $DIR_NAME/.tmux.conf ~/.tmux.conf
