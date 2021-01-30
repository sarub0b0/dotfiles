#!/bin/zsh

__anyenv () {
    path=(
        $HOME/.anyenv/bin(N-/)
        $path
    )

    if builtin command -v anyenv > /dev/null; then
        anyenv() {
            unfunction "$0"
            eval "$(anyenv init - zsh)"
            $0 "$@"
        }

        eval "$($HOME/dotfiles/zsh/anyenv_lazyload.zsh)"
    fi
}
__anyenv
