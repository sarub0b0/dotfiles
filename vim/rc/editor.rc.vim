" encording utf-8
set encoding=utf-8
setl fileencoding=utf-8
set fileencodings=utf-8,iso2022-jp,euc-jp,sjis
scriptencoding utf-8

filetype plugin indent on
syntax on

" setl spell spelllang=en,cjk

set helplang=ja,en

set equalalways

set formatoptions+=mM

" indent
set autoindent
setl foldmethod=indent

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
set cursorline
" highlight clear CursorLine
" set cursorcolumn
" 改行時,同じインデントで始める
" set smartindent
set visualbell
set visualbell t_vb=

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

set completeopt=menuone,menu

set wildignore=*.o,*.obj,GTAGS,GPATH,GRTAGS
" set complete=.,w,b,u,t

set grepprg=grep\ -rnHI


set number

set scrolloff=10

" set ttyfast

set t_Co=256

set pumheight=20

if has('nvim')
    set inccommand=nosplit
endif


if has('persistent_undo')
    set undodir=~/.cache/vimundo
    set undofile
endif

let tlist_tex_settings = 'latex;l:labels;c:chapter;s:sections;t:subsections;u:subsubsections'
set iskeyword=@,48-57,_,-,:,192-255


" let mapleader = "\<Space>"

" autocmd DeleteLineEndSpaceCmd BufWritePre * :keeppatterns %s/\s\+$//ge
autocmd DeleteLineEndSpaceCmd BufWritePre * call s:remove_tail_spaces()

function! s:remove_tail_spaces() abort
    let l:view = winsaveview()
    keeppatterns :%s/\s\+$//ge
    silent call winrestview(l:view)
endfunction

autocmd MyAutoCmd QuickFixCmdPost *grep* :rightbelow cwindow 7

" Auto-close quickfix window
autocmd MyAutoCmd WinEnter * if ((winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix')
            \| quit
            \| endif
autocmd MyAutoCmd WinEnter * if (winnr('$') == 2) && getbufvar(winbufnr(2), '&buftype') == 'quickfix' && exists("b:NERDTree") && b:NERDTree.isTabTree()
            \| quit
            \| quit
            \| endif

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

" if &term =~? 'xterm' && has('nvim')
"     let &t_SI .= "\e[?2004h"
"     let &t_EI .= "\e[?2004l"
"     let &pastetoggle = "\e[201~"

"     function XTermPasteBegin(ret)
"         set paste
"         return a:ret
"     endfunction

"     inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
" endif

" augroup foldmethod_changed_insert
"     autocmd!
"     autocmd InsertEnter * if !exists('w:last_fdm')
"                 \| let w:last_fdm=&foldmethod
"                 \| setlocal foldmethod=manual
"                 \| endif

"     autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
"                 \| let &l:foldmethod=w:last_fdm
"                 \| unlet w:last_fdm
"                 \| endif
" augroup END

