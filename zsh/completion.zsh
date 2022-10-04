# 補完機能の強化
fpath=(
    ${HOMEBREW_PREFIX}/opt/asdf/completions(N-/)
    ~/.zsh/completion(N-/)
    ${HOMEBREW_PREFIX}/share/zsh/site-functions(N-/)
    $fpath
)

[ -d ~/.ssh/conf.d ] && cache_hosts=(`fgrep -r --color=never "Host " $HOME/.ssh/conf.d | awk '{print $2}'`)

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

# 大文字小文字の区別なしで補完する
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

bindkey -e

# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:ssh:*' hosts on
zstyle ':completion:ssh:*' config on

if builtin command -v kubectl > /dev/null; then
    source <(kubectl completion zsh)
fi

