# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
    alias cb="cargo build"
    alias cr="cargo run"
    alias kt="kubetui"
    alias vim="nvim"
    alias v="nvim"
    alias dsi='devspace init'
    alias dse='devspace enter'
    alias dsd='devspace dev'
    alias dsds='devspace dev --skip-build'
    alias dsp='devspace purge'
    alias dsb='devspace build'
    alias tl='tldr'


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
        /usr/local/opt/llvm/bin(N-/)
        /usr/local/kubebuilder/bin(N-/)
        ${HOME}/.cargo/bin(N-/)
        ${KREW_ROOT:-$HOME/.krew}/bin(N-/)
        $path
    )

    export TERM=xterm-256color

    export DOCKER_BUILDKIT=1
    export COMPOSE_DOCKER_CLI_BUILD=1

    if [ "$(uname)" = 'Darwin' ]; then
        path=(
            /usr/local/sbin(N-/)
            /usr/local/opt/expat/bin(N-/)
            /usr/local/opt/sqlite/bin(N-/)
            $path
        )
        export CPLUS_INCLUDE_PATH=/usr/local/include:$HOME/work/include/
    else
    fi
}

__history () {
    export HISTFILE=${HOME}/.zsh_history
    export HISTSIZE=10000
    export SAVEHIST=10000

    setopt hist_reduce_blanks
    # setopt share_history
    setopt hist_save_no_dups
    setopt hist_expire_dups_first
}

__color () {
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

    LESS='-F -R -X'

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

source $HOME/dotfiles/zsh/completion.zsh
source $HOME/dotfiles/zsh/command.zsh

# 一番最後
__zcompile

[ -f ~/.zshrc.extend ] && source ~/.zshrc.extend

# if (which zprof > /dev/null 2>&1); then
#     zprof
# fi
