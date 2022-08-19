#!/bin/bash

set -eu

install_brew () {

    required_package=(curl git)

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

    asdf plugin add python

    asdf install python 2.7.18
    asdf global python 2.7.18
    asdf reshim python 2.7.18
    pip install -U pip

    asdf install python latest
    asdf global python latest
    asdf reshim python latest
    pip install -U pip
}

install_ruby () {
    check_asdf_installed

    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${HOMEBREW_PREFIX}/opt/openssl"

    asdf plugin add ruby
    asdf install ruby latest
    asdf global ruby latest
    asdf reshim ruby

    unset RUBY_CONFIGURE_OPTS
}

install_neovim_providers () {
    npm i -g neovim

    gem install neovim

    asdf global python 2.7.18
    pip install pynvim

    asdf global python latest
    pip install pynvim
}


install_brew

[ -e Brewfile ] && brew bundle

install_neovim_providers
