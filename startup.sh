#!/bin/bash

vim () {
    rm -rf $HOME/.vim
    rm -rf $HOME/.vimrc
    echo "$HOME/dotfiles/vimrc -> $HOME/.vim"
    echo "$HOME/dotfiles/vimrc/init.vim -> $HOME/.vimrc"

    ln -sf $HOME/dotfiles/vimrc $HOME/.vim
    ln -sf $HOME/dotfiles/vimrc/init.vim $HOME/.vimrc
}
neovim () {
    rm -rf $HOME/.config/nvim

    echo "$HOME/dotfiles/vimrc -> $HOME/.config/nvim"
    ln -sf $HOME/dotfiles/vimrc $HOME/.config/nvim
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

ln -sf $HOME/dotfiles/clang-format $HOME/.clang-format

vim
neovim
tmux
zsh
anyenv
kubectl-prompt
# completion
