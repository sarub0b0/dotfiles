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
    ln -sf $HOME/dotfiles/zshrc $HOME/.zshrc
    echo "Install zplugin"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
}

completion () {
    if [ "$(uname)" = 'Darwin' ]; then
        ln -sf /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion ./zsh/completions/_docker
    fi
}

anyenv () {
    git clone --depth 1 https://github.com/anyenv/anyenv ~/.anyenv
    zsh ~/.anyenv/bin/anyenv init
    if [ -d $HOME/.anyenv/plugins ]; then
        mkdir -p $HOME/.anyenv/plugins
    fi
    git clone --depth 1 https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
}

kubectl-prompt () {
    git clone --depth 1 https://github.com/superbrothers/zsh-kubectl-prompt.git $HOME/.zsh-kubectl-prompt
}

vim
tmux
zsh
anyenv
kubectl-prompt
# completion
