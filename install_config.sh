#!/bin/bash

# neovim

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vimrc/init.vim ~/.config/nvim/init.vim

# zsh
ln -sf ~/dotfiles/zshrc ~/.zshrc

# tmux
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
