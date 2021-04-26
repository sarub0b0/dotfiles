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
    alias kt="kubetui"


    if [ "$(uname)" = 'Darwin' ]; then
        alias ls='ls -G'
        alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
    else
        alias ls='ls --color=always'
    fi

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

    export DOCKER_BUILDKIT=1
    export COMPOSE_DOCKER_CLI_BUILD=1

    export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH


    if [ "$(uname)" = 'Darwin' ]; then
        path=(
            /usr/local/sbin(N-/)
            /usr/local/opt/expat/bin(N-/)
            /usr/local/opt/sqlite/bin(N-/)
            $path
        )
        export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/work/include/
        export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
        export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
    else
    fi
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


__zcompile () {
    if [ ! -f ~/.zshrc.zwc ] || [ $HOME/.zshrc -nt ~/.zshrc.zwc ]; then
        zcompile ~/.zshrc
    fi
    if [ ! -f ~/.zcompdump.zwc ] || [ $HOME/.zcompdump -nt ~/.zcompdump.zwc ]; then
        zcompile ~/.zcompdump
    fi
}


# 一番最初
__color
__alias
__prompt
__history
__envs

source $HOME/dotfiles/zsh/anyenv.zsh
source $HOME/dotfiles/zsh/completion.zsh
source $HOME/dotfiles/zsh/cloud.zsh
source $HOME/dotfiles/zsh/command.zsh

# 一番最後
__zcompile

if builtin command -v starship > /dev/null; then
    eval "$(starship init zsh)"
fi

# if (which zprof > /dev/null 2>&1); then
#     zprof
# fi



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
