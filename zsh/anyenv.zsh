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

        node_version=$(cat $NODENV_ROOT/version)
        ruby_version=$(cat $RBENV_ROOT/version)
        python_version=$(cat $PYENV_ROOT/version)

        path=(
            $NODENV_ROOT/versions/$node_version/bin(N-/)
            $RBENV_ROOT/versions/$ruby_version/bin(N-/)
            $PYENV_ROOT/versions/$python_version/bin(N-/)
            $path
        )
    fi
}
__anyenv
