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
}

__envs () {
    export EDITOR="vim"
    # export GOPATH="$GOROOT"

    export PATH="${HOME}/bin:${PATH}"
    export TERM=xterm-256color
    export XDG_CONFIG_HOME="${HOME}/.config"

    export HISTFILE=${HOME}/.zsh_history
    export HISTSIZE=50000
    export SAVEHIST=100000

    setopt hist_reduce_blanks

    export PATH="$GOPATH/bin:$PATH"

    export PATH="${NODENV_ROOT}/versions/12.11.1/bin:$PATH"


    export DOCKER_BUILDKIT=1
    export COMPOSE_DOCKER_CLI_BUILD=1


    # export PATH=$HOME/work/service-mesh/istio-1.4.2/bin:$PATH
    # export PATH=$HOME/work/service-mesh/istio-1.4.4/bin:$PATH
    export PATH=$HOME/work/service-mesh/istio-1.5.0/bin:$PATH

    if [ "$(hostname)" = "kosay-bbtower.local" ]; then
        export KUBECONFIG=$HOME/.kube/config-gke
    fi
}

__iterm2 () {
    echo -ne "\e]1;\U0001f412\U0001f412\U0001f412\a"
    echo -ne "\e]2;\U0001f412\U0001f412\U0001f412\a"
}


__mac () {
    alias ls='ls -G'
    alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

    # ADD bin directory
    export PATH="/usr/local/sbin:${PATH}"

    export PATH="/usr/local/opt/expat/bin:$PATH"
    export PATH="/usr/local/opt/sqlite/bin:$PATH"
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
    # RPROMPT="[%~]"
    # RPROMPT="[%(5~|…/%3~|%~)]"
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

    # fpath=(~/dotfiles/zsh/completions(N-/) $fpath)
}


__anyenv () {
    # if builtin command -v anyenv > /dev/null; then
    if [ "$(uname)" = 'Darwin' ]; then
        export PATH="/usr/local/opt/anyenv/bin:$PATH"
        alias brew="env PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin brew"
    else
        export PATH="$HOME/.anyenv/bin:$PATH"
    fi

    eval "$(anyenv init - --no-rehash)"
    # eval "$(anyenv init - )"
    # eval "$(anyenv lazyload)"
    # tmux対応
    env_dir=$HOME/.anyenv/envs
    for D in `ls $env_dir`
    do
        export PATH="$env_dir/$D/libexec:$PATH"
    done
    # fi
}

__nvim () {
    if builtin command -v nvim > /dev/null; then
        # alias vim='nvim'
        # alias vim='pyenv version > /dev/null; nvim'
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

    fvim () {
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
    PROMPT='%{$fg[green]%}%n %{$fg[$(__kubectl_prompt_color)]%}(%10>..>$ZSH_KUBECTL_CONTEXT%<</$ZSH_KUBECTL_NAMESPACE) %{$reset_color%}%(!.#.$) '
    zle reset-prompt
}

kubectl-disable () {
    __default_prompt
    zle reset-prompt
}

__zsh_kubectl_prompt () {
    source /usr/local/opt/zsh-kubectl-prompt/etc/zsh-kubectl-prompt/kubectl.zsh
    zle -N kubectl-enable kubectl-enable
    zle -N kubectl-disable kubectl-disable
    bindkey '^G^M' kubectl-enable
    bindkey '^G^N' kubectl-disable
}


# 一番最初
__color

__alias
__prompt
__anyenv
__nvim
__completion
# __zplugin
__fzf

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


if builtin command -v kubectl > /dev/null; then
    eval "$(kubectl completion zsh)"
fi
# __powerline_shell


# if (which zprof > /dev/null 2>&1) ;then
#     zprof
# fi
