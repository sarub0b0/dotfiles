scriptencoding utf-8

map <C-s> <Nop>

"----------------------------------------------------
" 検索のハイライト削除
"----------------------------------------------------
nnoremap <ESC><ESC> :noh<CR>

"----------------------------------------------------
" Man pager
"----------------------------------------------------
nnoremap <Space>m :<C-u>Man<CR>

"----------------------------------------------------
" QuickFix
"----------------------------------------------------
nnoremap <silent><C-q> :cclose<CR>

"----------------------------------------------------
" insert -> nomarl remap
"----------------------------------------------------
" inoremap <silent> jj <ESC>

"----------------------------------------------------
" terminal -> normal remap
"----------------------------------------------------
if has('terminal') || has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>
  " tnoremap <silent> jj <C-\><C-n>
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

nnoremap ss <C-w>s
nnoremap sv <C-w>v

tmap <C-s>h <ESC><C-w>h
tmap <C-s>i <ESC><C-w>i
tmap <C-s>j <ESC><C-w>j
tmap <C-s>k <ESC><C-w>k


"----------------------------------------------------
" j k remap
"----------------------------------------------------
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk


"----------------------------------------------------
" f bで左右移動（insert mode）
"----------------------------------------------------

inoremap <C-f> <Right>
inoremap <C-b> <Left>



nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>



"----------------------------------------------------
" load vimrc
"----------------------------------------------------
nmap ,v :edit $MYVIMRC<CR>
