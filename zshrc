# zmodload zsh/zprof && zprof

__alias () {

    alias slcvs='cvs -d :ext:kosay@asagao.jaist.ac.jp:/cvsroot'
    alias sudo='sudo -E'
    alias c='clear'
    alias sl='ls'
    alias ll='ls -lh'
    alias la='ls -lah'
    alias ..='cd ..'
    alias py='python'
    alias rb='ruby'
    # alias fgrep='fgrep --with-filename --line-number --color=always'
    alias grep='grep --line-buffered'
    alias cgrep='grep --line-buffered --color=always'
    alias gtags_remove='rm GPATH GRTAGS GTAGS'
    alias gobuild='go build'
    alias gitlogtree='git log --graph --date=iso --pretty="[%ad]%C(auto) %h%d %Cgreen%an%Creset : %s"'
    alias k='kubectl'
    alias kc='kubectl ctx'
    alias kn='kubectl ns'
    alias kv='kubeval'
    alias kvs='kubectl view-secret'
    alias kst='kubectl status'
    alias kb='kubie'
    alias tf='terraform'
    alias tp='telepresence'
    alias ds='devspace'
    alias sf='skaffold'
    alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
    alias cb="cargo build"
    alias cr="cargo run"
}

__history () {
    export HISTFILE=${HOME}/.zsh_history
    export HISTSIZE=10000
    export SAVEHIST=10000

    setopt hist_reduce_blanks
    setopt share_history
    setopt hist_save_no_dups
    setopt hist_expire_dups_first
}

__envs () {
    if builtin command -v nvim > /dev/null; then
        export EDITOR="nvim"
    fi

    path=(
        ${HOME}/bin(N-/)
        $GOPATH/bin(N-/)
        /usr/local/opt/llvm/bin(N-/)
        $HOME/work/service-mesh/istio-1.5.0/bin(N-/)
        /usr/local/kubebuilder/bin(N-/)
        ${KREW_ROOT:-$HOME/.krew}/bin(N-/)
        $path
    )

    export XDG_CONFIG_HOME="${HOME}/.config"

    export TERM=xterm-256color

    export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/work/include/

    export DOCKER_BUILDKIT=1
    export COMPOSE_DOCKER_CLI_BUILD=1


    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

}

__iterm2 () {
    echo -ne "\e]1;\U0001f412\U0001f412\U0001f412\a"
    echo -ne "\e]2;\U0001f412\U0001f412\U0001f412\a"
}


__mac () {
    alias ls='ls -G'
    alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

    # ADD bin directory
    path=(
        /usr/local/sbin(N-/)
        /usr/local/opt/expat/bin(N-/)
        /usr/local/opt/sqlite/bin(N-/)
        $path
    )
    export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
    export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
}

__linux () {
    alias ls='ls --color=always'

}

__color () {
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'


    LESS='-M'

    autoload colors
    colors
}

__default_prompt () {
    if [ "$(uname)" = "Darwin" ]; then
        PROMPT="%{$fg[green]%}%n %{$reset_color%}%(!.#.$) "
    else
        PROMPT="%{$fg[green]%}%n@%m %{$reset_color%}%(!.#.$) "
    fi
}

__prompt () {
    __default_prompt
    RPROMPT="[%{$fg[yellow]%}%(5~|%-1~/…/%3~|%4~)%{$reset_color%}]"
}

__completion () {
    # 補完機能の強化
    autoload -Uz compinit && compinit -i

    # #補完に関するオプション
    #setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
    setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
    setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
    #setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
    setopt auto_param_keys       # カッコの対応などを自動的に補完
    setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
    setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

    setopt complete_in_word      # 語の途中でもカーソル位置で補完
    setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示

    setopt print_eight_bit       # 日本語ファイル名等8ビットを通す
    setopt extended_glob         # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
    #setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ

    setopt list_packed           # リストを詰めて表示

    bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)

    # 補完候補を ←↓↑→ でも選択出来るようにする
    zstyle ':completion:*:default' menu select=2

    # 補完関数の表示を過剰にする編
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
    zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
    zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
    zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
    zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
    zstyle ':completion:*:options' description 'yes'

    bindkey -e

    # グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
    # したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
    zstyle ':completion:*' group-name ''

    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


    function _ssh {
        compadd `grep -r --color=never "^Host" ${HOME}/.ssh/conf.d/* | sed -e "s/^\/User.*Host *//" | sed -e "s/*//"`
    }

    if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
        source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
        source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
    fi
}


__anyenv () {
    path=(
        $HOME/.anyenv/bin(N-/)
        $path
    )

    if builtin command -v anyenv > /dev/null; then

        typeset -g anyenv_loaded=0
        anyenv() {
            unfunction "$0"
            if [ ${anyenv_loaded} -eq 0 ]; then
                eval "$(anyenv init - zsh)"
                anyenv_loaded=1
            fi
            $0 "$@"
        }

        eval "$($HOME/dotfiles/anyenv_lazyload)"

        node_version=$(cat $NODENV_ROOT/version)
        ruby_version=$(cat $RBENV_ROOT/version)

        path=(
            $NODENV_ROOT/versions/$node_version/bin(N-/)
            $RBENV_ROOT/versions/$ruby_version/bin(N-/)
            $path
        )
    fi
}

__nvim () {
    if builtin command -v nvim > /dev/null; then
        export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

        vim () {
            if [ -z "$initialized_pyenv" ]; then
                initialized_pyenv=1
                pyenv versions > /dev/null
            fi
            nvim $@
        }
    fi
}

__fzf () {

    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    if builtin command -v fzf > /dev/null; then
        export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

        gf () {
            local src=$(ghq list | fzf --preview "head -n 30 $(ghq root)/{}/README.*")
            if [ -n "$src" ]; then
                cd $(ghq root)/$src
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
        bindkey '^T' transpose-chars
    fi
}

__command () {
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
}

__zcomp () {
    if [ ! -f ~/.zshrc.zwc ] || [ $HOME/.zshrc -nt ~/.zshrc.zwc ]; then
        zcompile ~/.zshrc
    fi
    if [ ! -f ~/.zcompdump.zwc ] || [ $HOME/.zcompdump -nt ~/.zcompdump.zwc ]; then
        zcompile ~/.zcompdump
    fi
}

__kubectl_prompt_color() {
    [[ "$ZSH_KUBECTL_USER" =~ "admin" ]] && color=red || color=blue
    echo "$color"
}

kubectl-enable () {
    __read_zsh_prompt

    PROMPT=$'%{$fg[$(__kubectl_prompt_color)]%}gcp: $ZSH_GCLOUD_PROMPT\nk8s: ($ZSH_KUBECTL_CONTEXT:$ZSH_KUBECTL_NAMESPACE)\n%{$fg[green]%}%n %{$reset_color%}%(!.#.$) '
    zle reset-prompt
}

kubectl-disable () {
    __default_prompt
    zle reset-prompt
}

__read_zsh_prompt () {
    if [ -f $HOME/.zsh-kubectl-prompt/kubectl.zsh ]; then
        source $HOME/.zsh-kubectl-prompt/kubectl.zsh
    fi
    if [ -f $HOME/.zsh-gcloud-prompt/gcloud.zsh ]; then
        source $HOME/.zsh-gcloud-prompt/gcloud.zsh
    fi
}

__zsh_kubectl_prompt () {
    zle -N kubectl-enable kubectl-enable
    zle -N kubectl-disable kubectl-disable
    bindkey '^G^M' kubectl-enable
    bindkey '^G^N' kubectl-disable
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

kgetall () {
    list=$(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq )

    for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq );
    do
        resource=$(kubectl get --ignore-not-found ${i})
        if ! [ -z "$resource" ]; then
            echo "Resource: " ${i}
            echo "$resource"
        fi
    done
    unset i
}


pf_argo_prod () {
    local port=$1
    kubectl port-forward -n argocd --context gke_pro-bbtower-portal_asia-northeast1_pro-portal-cluster svc/argocd-server $port:443 &
    while (true);
    do
        curl localhost:$port -s > /dev/null;
        sleep 30;
    done
}

pf_argo_dev () {
    local port=$1
    kubectl port-forward -n argocd --context gke_dev-bbtower-portal_asia-northeast1-a_dev-portal-cluster svc/argocd-server $port:443 &
    while (true);
    do
        curl localhost:$port -s > /dev/null;
        sleep 30;
    done
}


kwatch () {
    local resource=""
    local namespace=""
    if [ -z "$1" ]; then
        resource="all,ing,secret,cm,pvc,pv"
    else
        resource=$1
    fi

    if [ -n "$2" ]; then
        namespace="-n $2"
    fi


    watch kubectl get $resource $namespace
}

ktop () {
    local target="pod"
    if [ -z "$1" ]; then
        target=pod
    else
        target=$1
    fi
    watch kubectl top $target
}

if builtin command -v kubectl > /dev/null; then
    kubectl() {
        unfunction "$0"
        source <(kubectl completion zsh)
        $0 "$@"
    }
fi

# 一番最初
__color

__alias
__prompt
__anyenv
__nvim
__completion
__fzf
__z

__history
__envs


__zsh_kubectl_prompt

if [ "$(uname)" = 'Darwin' ]; then
    __mac
    __iterm2
else
    __linux
fi

# 一番最後
__command
__zcomp

# if (which zprof > /dev/null 2>&1); then
#     zprof
# fi
