scriptencoding utf-8

"----------------------------------------------------
" 検索のハイライト削除
"----------------------------------------------------
nnoremap <ESC><ESC> :noh<CR>

"----------------------------------------------------
" Man pager
"----------------------------------------------------
nnoremap <Space>m <Plug>ManPreGetPage<CR>

"----------------------------------------------------
" QuickFix
"----------------------------------------------------
nnoremap <silent><C-q> :cclose<CR>

"----------------------------------------------------
" 閉じかっこ自動補完
"----------------------------------------------------
"inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
"inoremap [ []<Left>
inoremap [<Enter> []<Left><CR><ESC><S-o>
"inoremap " ""<ESC>i
" inoremap "<Enter> ""<Left><CR><ESC><S-o>
"inoremap ' ''<ESC>i
" inoremap '<Enter> ''<Left><CR><ESC><S-o>

"----------------------------------------------------
" insert -> nomarl remap
"----------------------------------------------------
inoremap <silent> jj <ESC>

"----------------------------------------------------
" terminal -> normal remap
"----------------------------------------------------
if has('terminal') || has('nvim')
    tnoremap <silent> <ESC> <C-\><C-n>
    tnoremap <silent> jj <C-\><C-n>
endif

"----------------------------------------------------
" disable ex mode
"----------------------------------------------------
nnoremap Q <Nop>

"----------------------------------------------------
" ^$* remap
"----------------------------------------------------
noremap <Space>h  ^
noremap <Space>l  $
nnoremap <Space>/  *

"----------------------------------------------------
" window分割
"----------------------------------------------------
map s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

nnoremap st <C-w>t
nnoremap sb <C-w>b
nnoremap sp <C-w>p

nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

nnoremap sr <C-w>r
nnoremap sR <C-w>R
nnoremap s= <C-w>=
nnoremap s0 <C-w>=
nnoremap sx <C-w>x

nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>


"----------------------------------------------------
" j k remap
"----------------------------------------------------
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"----------------------------------------------------
" GNU GLOBAL(gtags)
"----------------------------------------------------
autocmd MyAutoCmd FileType c,cpp,h,java :call s:gtags_remap()

function! s:gtags_remap()
    if executable('gtags')
        nnoremap <C-g> :Gtags -g<Space>
        nnoremap <C-l> :Gtags -f %<CR>
        nnoremap <C-j> :Gtags <C-r><C-w><CR>
        nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
        nnoremap <S-u> :GtagsUpdate<CR>
    endif
endfunction

nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>
