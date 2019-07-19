#!/bin/bash

vim () {
    mkdir -p $HOME/.config/nvim
    ln -sf $HOME/dotfiles/vim/vimrc $HOME/.config/nvim/init.vim
    ln -sf $HOME/dotfiles/vim/vimrc $HOME/.vimrc
}

tmux () {
    ln -sf $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
}

zsh () {
    ln -sf $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
    echo "Install zplugin"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
}

completion () {
    if [ "$(uname)" = 'Darwin' ]; then
        ln -sf /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion ./zsh/completions/_docker
    fi
}

vim
tmux
zsh

# completion
