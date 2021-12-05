" encording utf-8
set encoding=utf-8
setl fileencoding=utf-8
set fileencodings=utf-8,iso2022-jp,euc-jp,sjis
scriptencoding utf-8

filetype plugin indent on
syntax on


set shortmess+=I

set updatetime=3000

" Explore
let g:netrw_liststyle = 3
let g:netrw_preview = 1
let g:netrw_winsize = 20
let g:netrw_list_hide = '^\..*'

set helplang=ja,en

set equalalways

set formatoptions+=mM

" indent
set autoindent
" setl foldmethod=indent
let g:vim_indent_cont = 4

" タブ設定
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set list
set listchars=tab:\-\-

" 編集中のファイルが変更されたら自動でロード
set autoread

" 現在の行を強調
set nocursorline

set visualbell
set visualbell t_vb=

set hidden

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
"set ignorecase
set noignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan

set wildmode=list:longest,full

set dictionary=/usr/share/dict/words

set completeopt=menuone,menu

set wildignore=*.o,*.obj,GTAGS,GPATH,GRTAGS,core
" set complete=.,w,b,u,t

set grepprg=grep\ -rnHI


set number

set scrolloff=10

" set ttyfast

set t_Co=256

set pumheight=20

if has('persistent_undo')
  set undodir=~/.cache/vimundo
  set undofile
endif

let tlist_tex_settings = 'latex;l:labels;c:chapter;s:sections;t:subsections;u:subsubsections'
set iskeyword=@,48-57,_,-,192-255


let g:mapleader = "\\"
let g:maplocalleader = "\\"


"クリップボードからコピペする際のインデントのズレを防ぐ
if &term =~? 'xterm'
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

if has('nvim')
  set cursorline

  set inccommand=nosplit

  if has('mac')
    let g:clipboard = {
      \   'name': 'pbcopy',
      \   'copy': {
      \     '+': 'pbcopy',
      \     '*': 'pbcopy'
      \   },
      \   'paste': {
      \     '+': 'pbpaste',
      \     '*': 'pbpaste'
      \   },
      \   'cache_enabled': 0
      \ }
  endif

  if has('wsl')
    let g:clipboard = {
        \   'name': 'win32yank',
        \   'copy': {
        \     '+': 'win32yank.exe -i',
        \     '*': 'win32yank.exe -i'
        \    },
        \     'paste': {
        \       '+': 'win32yank.exe -o',
        \       '*': 'win32yank.exe -o'
        \   },
        \   'cache_enabled': 1
        \ }
  endif
  set clipboard&
  set clipboard+=unnamedplus

  set pumblend=10
  set winblend=10
else
  set nocursorline

  set clipboard^=unnamedplus,autoselect
endif


