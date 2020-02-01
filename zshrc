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
    export PATH="${HOME}/bin:${PATH}"
    export TERM=xterm-256color
    export XDG_CONFIG_HOME="${HOME}/.config"

    export HISTFILE=${HOME}/.zsh_history
    export HISTSIZE=50000
    export SAVEHIST=100000

    setopt hist_reduce_blanks

    export GOPATH=~/.go

    export DOCKER_BUILDKIT=1
    export COMPOSE_DOCKER_CLI_BUILD=1

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

__prompt () {
    if [ "$(uname)" = "Darwin" ]; then
        PROMPT="%{$fg[green]%}%n %{$reset_color%}%(!.#.$) "
    else
        PROMPT="%{$fg[green]%}%n@%m %{$reset_color%}%(!.#.$) "
    fi
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



        # function fd() {
        #     local dir
        #     dir=$(find ${1:-.} -path '*/\.*' -prune \
        #         -o -type d -print 2> /dev/null | fzf +m) &&
        #     cd "$dir"
        # }
        # # Use ~~ as the trigger sequence instead of the default **
        # export FZF_COMPLETION_TRIGGER='~~'
        # # # Options to fzf command
        # export FZF_COMPLETION_OPTS='+c -x'
        # # # Use fd (https://github.com/sharkdp/fd) instead of the default find
        # # # command for listing path candidates.
            # # # - The first argument to the function ($1) is the base path to start traversal
            # # # - See the source code (completion.{bash,zsh}) for the details.
                # function _fzf_compgen_path() {
                #     fd --hidden --follow --exclude ".git" . "$1"
                # }

        # # # Use fd to generate the list for directory completion
            # function _fzf_compgen_dir() {
            #     fd --type d --hidden --follow --exclude ".git" . "$1"
            # }
            # complete -F _fzf_path_completion -o default -o bashdefault ag
            # complete -F _fzf_dir_completion -o default -o bashdefault tree
    fi

}

# ___p9k () {
#         POWERLEVEL9K_MODE="nerdfont-complete"

#         # battery
#         # POWERLEVEL9K_BATTERY_LOW_BACKGROUND='none'
#         POWERLEVEL9K_BATTERY_LOW_FOREGROUND='001'
#         # POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='none'
#         POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='076'
#         # POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='none'
#         POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='076'
#         # POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='none'
#         POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='003'
#         POWERLEVEL9K_BATTERY_LOW_THRESHOLD=15
#         POWERLEVEL9K_BATTERY_VERBOSE=false

#         POWERLEVEL9K_BATTERY_STAGES=($'\uf244 ' $'\uf243 ' $'\uf242 ' $'\uf241 ' $'\uf240 ')
#         # POWERLEVEL9K_BATTERY_STAGES=(
#         #    $'▏    ▏' $'▎    ▏' $'▍    ▏' $'▌    ▏' $'▋    ▏' $'▊    ▏' $'▉    ▏' $'█    ▏'
#         #    $'█▏   ▏' $'█▎   ▏' $'█▍   ▏' $'█▌   ▏' $'█▋   ▏' $'█▊   ▏' $'█▉   ▏' $'██   ▏'
#         #    $'██   ▏' $'██▎  ▏' $'██▍  ▏' $'██▌  ▏' $'██▋  ▏' $'██▊  ▏' $'██▉  ▏' $'███  ▏'
#         #    $'███  ▏' $'███▎ ▏' $'███▍ ▏' $'███▌ ▏' $'███▋ ▏' $'███▊ ▏' $'███▉ ▏' $'████ ▏'
#         #    $'████ ▏' $'████▎▏' $'████▍▏' $'████▌▏' $'████▋▏' $'████▊▏' $'████▉▏' $'█████▏' )
#         # POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(red1 orangered1 darkorange orange1 gold1 yellow1 yellow2 greenyellow chartreuse1 chartreuse2 green1)

#         # user
#         # POWERLEVEL9K_USER_DEFAULT_FOREGROUND='green'
#         # POWERLEVEL9K_USER_DEFAULT_BACKGROUND='none'
#         # POWERLEVEL9K_USER_SUDO_FOREGROUND='green'
#         # POWERLEVEL9K_USER_ROOT_FOREGROUND='red'
#         # POWERLEVEL9K_USER_ICON="\uF415" # 
#         # POWERLEVEL9K_ROOT_ICON="#"
#         # POWERLEVEL9K_SUDO_ICON=$'\uF09C' # 
#         POWERLEVEL9K_ALWAYS_SHOW_USER=true
#         POWERLEVEL9K_USER_TEMPLATE="%n %(!.#.$)"

#         # dir
#         # POWERLEVEL9K_DIR_ICON_FOREGROUND='white'
#         # POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
#         # POWERLEVEL9K_DIR_HOME_BACKGROUND='none'
#         # POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
#         # POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='none'
#         # POWERLEVEL9K_DIR_HOME_ETC_FOREGROUND='white'
#         # POWERLEVEL9K_DIR_HOME_ETC_BACKGROUND='none'
#         POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
#         POWERLEVEL9K_SHORTEN_DELIMITER=""
#         POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
#         # vcs
#         # POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
#         # POWERLEVEL9K_VCS_CLEAN_BACKGROUND='none'
#         # POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
#         # POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='none'
#         # POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
#         # POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='none'


#         # context
#         POWERLEVEL9K_ALWAYS_SHOW_USER=true
#         POWERLEVEL9K_CONTEXT_TEMPLATE="%n %(!.#.$)"
#         POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="none"

#         # POWERLEVEL9K_CONTEXT_TEMPLATE="%F{cyan}%n%f"
#         # prompt
#         POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
#         POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context)
#         POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(dir_writable dir battery)

#         POWERLEVEL9K_USE_CACHE=true
#     }

# __zplug () {
#     export ZPLUG_HOME=$HOME/.zplug
#     source $ZPLUG_HOME/init.zsh

#     zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
#     zplug 'zsh-users/zsh-completions', use:'src/_*', lazy:true

#     ___p9k

#     if [ ! ~/.zplug/last_zshrc_check_time -nt ~/.zshrc ]; then
#         touch ~/.zplug/last_zshrc_check_time
#         if ! zplug check --verbose; then
#             printf "Install? [y/N]: "
#             if read -q; then
#                 echo; zplug install
#             fi
#         fi
#     fi
#     zplug load
#     # zplug check --verbose || zplug install
#     # zplug load
# }

# __zplugin () {
#     source "$HOME/.zplugin/bin/zplugin.zsh"
#     autoload -Uz _zplugin
#     (( ${+_comps} )) && _comps[zplugin]=_zplugin

#     # zpcompinit -C
#     zplugin ice wait"0" blockf silent
#     zplugin light zsh-users/zsh-completions


#     # zplugin light bhilburn/powerlevel9k
#     # zplugin ice wait'!0' atload"zsh-users/zsh-completions"

#     zpcompinit -C
#     # autoload -Uz compinit && compinit -C

#     # ___p9k
# }

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

# __powerline_go () {
#     function powerline_precmd() {
#         eval "$($GOPATH/bin/powerline-go -error $? -shell zsh -eval \
#             -modules user -modules-right perms,gitlite,cwd -cwd-mode plain \
#             -max-width 30 -cwd-max-dir-size 5 -colorize-hostname -cwd-max-depth 10)"
#     }

#     function install_powerline_precmd() {
#         for s in "${precmd_functions[@]}"; do
#             if [ "$s" = "powerline_precmd" ]; then
#                 return
#             fi
#         done
#         precmd_functions+=(powerline_precmd)
#     }

#     if [ "$TERM" != "linux" ]; then
#         install_powerline_precmd
#     fi
# }

# __powerline_shell () {
#     function powerline_precmd() {
#         PS1="$(powerline-shell --shell zsh $?)"
#     }

#     function install_powerline_precmd() {
#         for s in "${precmd_functions[@]}"; do
#             if [ "$s" = "powerline_precmd" ]; then
#                 return
#             fi
#         done
#         precmd_functions+=(powerline_precmd)
#     }

#     if [ "$TERM" != "linux" ]; then
#         install_powerline_precmd
#     fi
# }

# 一番最初
__color

__alias
__envs
__prompt
__anyenv
__nvim
__completion
# __zplugin
__fzf

if [ "$(uname)" = 'Darwin' ]; then
    __mac
    __iterm2
else
    __linux
fi
# 一番最後
__command

__zcomp

# __powerline_shell


# if (which zprof > /dev/null 2>&1) ;then
#     zprof
# fi
