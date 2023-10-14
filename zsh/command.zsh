#!/bin/zsh

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

fv () {
    files=$(git ls-files) && \
        selected_files=$(echo "$files" |\
        fzf -m --preview 'head -100 {}') &&\
        vim $selected_files
}

__z () {
    if builtin command -v fzf > /dev/null && builtin command -v zshz > /dev/null; then
        unalias z
        function z () {
            if [[ -z "$*" ]]; then
                cd "$(zshz -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
            else
                _last_z_args="$@"
                _z "$@"
            fi
        }

        function zz () {
            cd "$(zshz -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
        }

        alias j=z
        alias jj=zz
    fi
}

__fzf () {

    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

    __ghq_select_repo () {
        echo "$(ghq list | fzf --preview "head -n 30 $(ghq root)/{}/README.*")"
    }

    dev () {
        local repo=$(__ghq_select_repo)
        local prev_dir=${PWD}
        if [ -n "$repo" ]; then
            cd $(ghq root)/$repo
            tmux new-session \; send-keys "vim" C-m
            cd $prev_dir
        fi
    }

    gf () {
        local repo=$(__ghq_select_repo)
        if [ -n "$repo" ]; then
            cd $(ghq root)/$repo
        fi
    }

    if [ "$(uname)" = "Darwin" ]; then
        gfb () {
            local repo=$(__ghq_select_repo)
            if [ -n "$repo" ]; then
                open https://$repo
            fi
        }
    fi

    fd () {
        local dir
        dir=$(find ${1:-.} -path '*/\.*' -prune \
            -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
    }
}

__fzf
__z
