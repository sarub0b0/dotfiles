alias slcvs='cvs -d :ext:kosay@asagao.jaist.ac.jp:/cvsroot'
alias sudo='sudo -E'
alias c='clear'
alias sl='ls'
alias ll='ls -lh'
alias la='ls -lah'
alias ..='cd ..'
alias py='python'
alias rb='ruby'
alias rbe='rbenv'
alias fgrep='grep --with-filename --line-number --color=always'
alias grep='grep --color=always'
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias gtags_remove='rm GPATH GRTAGS GTAGS'
alias gobuild='go build'
alias cc='cc -Wall -std=c11'
alias gcc='gcc -Wall -std=c11'
alias clang='clang -W -std=c11'
alias gitlogtree="git log --graph --date=iso --pretty='[%ad]%C(auto) %h%d %Cgreen%an%Creset : %s'"

set -g fish_prompt_pwd_dir_length 0

set -x EDITOR vim
set -x PATH $PATH $HOME/bin/
set -x TERM xterm-256color
set -x XDG_CONFIG_HOME $HOME/.config

alias ls='ls -G'
alias vim nvim

#LDFLAGS="-L/usr/local/opt/llvm/lib/clang"
#CPPFLAGS="-I/usr/local/opt/llvm/include"
#alias cc="cc $LDFLAGS $CPPFLAGS"
#alias gcc="gcc $LDFLAGS $CPPFLAGS"
#alias clang="/usr/local/opt/llvm/bin/clang $LDFLAGS $CPPFLAGS"

#set -x  PATH $PATH /usr/local/opt/gnu-tar/libexec/gnubin
#set -x  MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"

# ADD bin directory
#export PATH="/usr/local/sbin/:$PATH"

# llvm
#export PATH="/usr/local/opt/llvm/bin:$PATH"

# Android device monitor
#export PATH="$HOME/Library/Android/sdk/platform-tools/:$PATH"
#export PATH="$HOME/Library/Android/sdk/tools/:$PATH"

# completions
#fpath=(~/dotfiles/completions(N-/) $fpath)
#fpath=(~/dotfiles/docker-zsh-completions(N-/) $fpath)

# rbenv
#set -x RBENV_ROOT $HOME/.rbenv
#set -x PATH $PATH $RBENV_ROOT/bin
# jenv
#set -x PATH $PATH $HOME/.jenv/bin

## go
#if builtin command -v go > /dev/null; then
#    export GOPATH="$HOME/go"
#fi

# goenv
set -x PATH $PATH $HOME/.goenv/bin

alias less='/usr/share/vim/vim80/macros/less.sh'

#LS_COLORSを設定しておく
set -x LS_COLORS 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status
    set -l normal (set_color normal)

    # Hack; fish_config only copies the fish_prompt function (see #736)
    if not set -q -g __fish_classic_git_functions_defined
        set -g __fish_classic_git_functions_defined

        function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        # initialize our new variables
        if not set -q __fish_classic_git_prompt_initialized
            set -qU fish_color_user
            or set -U fish_color_user -o green
            set -qU fish_color_host
            or set -U fish_color_host -o cyan
            set -qU fish_color_status
            or set -U fish_color_status red
            set -U __fish_classic_git_prompt_initialized
        end
    end

    set -l color_cwd
    set -l prefix
    set -l suffix
    switch $USER
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '$'
    end

    set -l prompt_status
    if test $last_status -ne 0
        set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
    end

    echo -n -s (set_color $fish_color_user) "$USER" $normal ' ' $suffix ' '
end

function fish_right_prompt --description 'Write out the right prompt'
	set -l last_status $status
    set -l normal (set_color normal)

    # Hack; fish_config only copies the fish_prompt function (see #736)
    if not set -q -g __fish_classic_git_functions_defined
        set -g __fish_classic_git_functions_defined

        function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
            if status --is-interactive
                commandline -f repaint ^/dev/null
            end
        end

        # initialize our new variables
        if not set -q __fish_classic_git_prompt_initialized
            set -qU fish_color_user
            or set -U fish_color_user -o green
            set -qU fish_color_host
            or set -U fish_color_host -o cyan
            set -qU fish_color_status
            or set -U fish_color_status red
            set -U __fish_classic_git_prompt_initialized
        end
    end

    set -l prompt_status
    if test $last_status -ne 0
        set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
    end

    echo -n -s "[" (prompt_pwd) "]"
#    echo -n -s "[" (prompt_pwd) "]" $normal (__fish_vcs_prompt) $normal $prompt_status
end

