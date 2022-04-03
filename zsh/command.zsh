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
    if [ "$(uname)" = "Darwin" ]; then
        source /usr/local/opt/z/etc/profile.d/z.sh

        if builtin command -v fzf > /dev/null; then
            unalias z
            z() {
                if [[ -z "$*" ]]; then
                    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
                else
                    _last_z_args="$@"
                    _z "$@"
                fi
            }

            zz() {
                cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
            }

            alias j=z
            alias jj=zz
        fi
    fi
}

__fzf () {

    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    bindkey '^T' transpose-chars

    if builtin command -v fzf > /dev/null; then
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

        cd() {
            if [[ "$#" != 0 ]]; then
                builtin cd "$@";
                return
            fi
            local lscmd='ls -p --color=always'
            if [ "$(uname)" = 'Darwin' ]; then
                lscmd='ls -p -FG'
            fi
            local fzf_preview_opt=' __cd_nxt="$(echo {})";
                    __cd_path="$(echo ${__cd_nxt} | sed "s;//;/;")";
                    echo $__cd_path;
                    echo;
                    '"${lscmd} "'"${__cd_nxt}";
            '
            local lsd=$(echo $HOME && echo ".." && find . -maxdepth 3 -type d -not -path '*/\.*' -and -not -path '\.')
            local dir="$(printf '%s\n' "${lsd[@]}" | fzf --reverse --preview $fzf_preview_opt)"
            [[ ${#dir} != 0 ]] || return 0
            builtin cd "$dir" &> /dev/null
        }
    fi
}

__google_cloud_sdk () {

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/usr/local/opt/google-cloud-sdk/path.zsh.inc' ]; then
        . '/usr/local/opt/google-cloud-sdk/path.zsh.inc';
    fi

    # The next line enables shell command completion for gcloud.
    if [ -f '/usr/local/opt/google-cloud-sdk/completion.zsh.inc' ]; then
        . '/usr/local/opt/google-cloud-sdk/completion.zsh.inc';
    fi

}

__fzf
__z
__google_cloud_sdk
