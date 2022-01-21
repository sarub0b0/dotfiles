#!/bin/zsh

__anyenv () {
    path=(
        $HOME/.anyenv/bin(N-/)
        $path
    )

    if builtin command -v anyenv > /dev/null; then

        if builtin command -v p10k > /dev/null; then
            eval "$(anyenv init - zsh)"

        else
            anyenv() {
                unfunction "$0"
                eval "$(anyenv init - zsh)"
                $0 "$@"
            }

            eval "$($HOME/dotfiles/zsh/anyenv_lazyload.zsh)"
        fi
    fi
}
__anyenv
