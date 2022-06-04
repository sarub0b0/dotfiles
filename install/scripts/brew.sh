#!/bin/bash

set -ue

if ! builtin command -v brew > /dev/null; then

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

    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/$(profile)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fi
