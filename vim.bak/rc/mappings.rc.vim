scriptencoding utf-8

map <C-s> <Nop>

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

"""""""""""""""""""""""""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""""""""""""""""""""""""
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <Space>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <silent><Space>f  <Plug>(coc-format-selected)<CR>
nmap <silent><Space>f  <Plug>(coc-format)

" Remap keys for applying codeAction to the current line.
nmap <Space>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <Space>q  <Plug>(coc-fix-current)
xmap <Space>q  :CocFix<CR>

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


"""""""""""""""""""""""""""""""""""""""""""""""""
" coc-snippets
"""""""""""""""""""""""""""""""""""""""""""""""""
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

inoremap <silent><expr> <C-j> pumvisible() ? coc#_select_confirm() :
      \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()

nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""
" coc-git
"""""""""""""""""""""""""""""""""""""""""""""""""
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)


"""""""""""""""""""""""""""""""""""""""""""""""""
" coc-explorer
"""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Space>n :CocCommand explorer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""
" coc-actions
"""""""""""""""""""""""""""""""""""""""""""""""""
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <Space>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <Space>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

"----------------------------------------------------
" If foldmethod is syntax
"----------------------------------------------------
autocmd MyAutoCmd BufReadPost * if &l:foldmethod ==# 'syntax' | call s:undo_redo_foldmethod()

function! s:undo_redo_foldmethod()
  nmap <silent> u :setlocal foldmethod=manual<CR>
        \:normal! u<CR>
        \:setlocal foldmethod=syntax<CR>

  nmap <silent> <C-r> :setlocal foldmethod=manual<CR>
        \:redo<CR>
        \:setlocal foldmethod=syntax<CR>
endfunction

nmap ,v :edit $MYVIMRC<CR>


"----------------------------------------------------
" coc-floaterm
"----------------------------------------------------
let g:floaterm_keymap_toggle = '<Space>\'


"----------------------------------------------------
" coc-translator
"----------------------------------------------------
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
