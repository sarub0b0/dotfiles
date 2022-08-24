#!/bin/bash

set -e

sudo=""
[ "$(whoami)" != "root" ] && sudo="sudo"

if builtin command -v zypper > /dev/null; then
    eval "$sudo zypper install -y -t pattern devel_basis"
    eval "$sudo zypper install -y curl procps file git"
fi
if builtin command -v apt-get > /dev/null; then
    eval "$sudo apt-get install -y build-essential curl procps file git"
fi


install_brew () {

    required_package=(curl git ps)

    for p in ${required_package[@]}; do
        if ! builtin command -v $p > /dev/null; then
            echo "${p} not found"
            exit 1
        fi
    done

    profile () {
        case $SHELL in
            *zsh)
                echo ".zprofile"
                ;;
            *bash)
                echo ".bash_profile"
                ;;
            *)
                echo ".profile"
                ;;
        esac

    }

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    case $(uname) in
        Linux)
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/$(profile)
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            ;;
        Darwin)
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/$(profile)
            eval "$(/opt/homebrew/bin/brew shellenv)"
            ;;
    esac
}

setup_asdf () {
    profile () {
        case $SHELL in
            *zsh)
                echo ".zprofile"
                ;;
            *bash)
                echo ".bash_profile"
                ;;
            *)
                echo ".profile"
                ;;
        esac

    }

    echo 'source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh' >> ~/$(profile)
}

check_asdf_installed () {
    if ! builtin command -v asdf > /dev/null ; then
        echo "asdf not found"
        exit 1
    fi

}

install_nodejs () {
    check_asdf_installed

    asdf plugin add nodejs
    asdf install nodejs latest
    asdf global nodejs latest
    asdf reshim nodejs
}

install_python () {
    check_asdf_installed

    export LDFLAGS="-L$HOMEBREW_PREFIX/opt/zlib/lib -L$HOMEBREW_PREFIX/opt/bzip2/lib -L$HOMEBREW_PREFIX/opt/openssl@1.1/lib -L$HOMEBREW_PREFIX/opt/readline/lib"
    export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/zlib/include -I$HOMEBREW_PREFIX/opt/bzip2/include -I$HOMEBREW_PREFIX/opt/openssl@1.1/include -I$HOMEBREW_PREFIX/opt/readline/include"

    asdf plugin add python

    asdf install python 2.7.18
    asdf global python 2.7.18
    asdf reshim python
    pip install -U pip

    asdf install python 3.10.6
    asdf global python 3.10.6
    asdf reshim python
    pip install -U pip

}

install_ruby () {
    check_asdf_installed

    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${HOMEBREW_PREFIX}/opt/openssl"
    export LDFLAGS="-L$HOMEBREW_PREFIX/opt/zlib/lib "
    export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/zlib/include"

    asdf plugin add ruby
    asdf install ruby latest
    asdf global ruby latest
    asdf reshim ruby
}

install_neovim_providers () {
    #install_nodejs
    #install_ruby
    install_python

    npm i -g neovim

    gem install neovim

    asdf global python 2.7.18
    pip install pynvim

    asdf global python 3.10.6
    pip install pynvim
}

create_symbolic_link () {
    mkdir -p ~/.config/nvim
    ln -sf ~/dotfiles/vimrc/init.vim ~/.config/nvim/init.vim

    ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/zshrc ~/.zshrc
    ln -sf ~/dotfiles/asdfrc ~/.asdfrc
    ln -sf ~/dotfiles/markdownlintrc ~/.markdownlintrc
    ln -sf ~/dotfiles/gitconfig ~/.gitconfig
    ln -sf ~/dotfiles/clang-format ~/.clang-format

    mkdir -p ~/.config/git/
    ln -sf ~/dotfiles/gitignore ~/.config/git/ignore
}


install_brew

[ -e Brewfile ] && brew bundle

source ${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh

install_neovim_providers

create_symbolic_link
