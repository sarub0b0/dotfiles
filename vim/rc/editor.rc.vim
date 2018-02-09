
" encording utf-8
set encoding=utf-8
setl fileencoding=utf-8
set fileencodings=utf-8,iso2022-jp,euc-jp,sjis
scriptencoding utf-8

set helplang=ja,en

set equalalways

" indent
set autoindent

" タブ設定
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set list listchars=tab:\-\-

" 編集中のファイルが変更されたら自動でロード
set autoread

" 現在の行を強調
set cursorline
" highlight clear CursorLine
" set cursorcolumn
" 改行時,同じインデントで始める
" set smartindent
set visualbell

set hidden


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan

set wildmode=list:longest,full

set dictionary=/usr/share/dict/words

set completeopt=menuone,longest,menu

set complete=.,w,b,u,t,i,d


syntax on

filetype plugin indent on

set number

set scrolloff=5

set ttyfast

set t_Co=256

set pumheight=20

" let mapleader = "\<Space>"
"
augroup DeleteSpace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//ge
augroup END

augroup FoldMethod
    autocmd!
    autocmd FileType * setl foldmethod=indent
    set foldcolumn=2
augroup END

augroup QuickFixCmd
    autocmd!
    autocmd QuickFixCmdPost *grep* :rightbelow cwindow 7
augroup END

augroup QfAutoCommands
    autocmd!
    " Auto-close quickfix window
    autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END


"クリップボードからコピペする際のインデントのズレを防ぐ
if &term =~? 'xterm'
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif




