#!/bin/bash

set -ue

if ! builtin command -v asdf > /dev/null; then
    profile () {
        case $SHELL in
            *zsh)
                echo ".zshrc"
                ;;
            *bash)
                echo ".bashrc"
                ;;
            *)
                echo ".profile"
                ;;
        esac

    }

    brew install asdf

    echo '[ -d "${HOMEBREW_PREFIX}/opt/asdf" ] && . ${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh' >> ~/$(profile)

    . $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi
