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
    if builtin command -v fzf > /dev/null; then
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

    fd () {
        local dir
        dir=$(find ${1:-.} -path '*/\.*' -prune \
            -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
    }
}

__google_cloud_sdk () {

    if [ -d "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ]; then
        # The next line updates PATH for the Google Cloud SDK.
        . ${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
        # The next line enables shell command completion for gcloud.
        . ${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    fi
}

__fuck () {
    if builtin command -v thefuck > /dev/null; then
        eval $(thefuck --alias)
    fi
}

__fzf
__z
__google_cloud_sdk
__fuck
