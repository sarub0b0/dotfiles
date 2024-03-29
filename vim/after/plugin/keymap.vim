if get(g:, 'loaded_fzf_vim', 0)
  nnoremap <silent> <Leader>f :GFiles<CR>
  nnoremap <silent> <Leader>F :Files<CR>

  nnoremap <silent> <Leader>b :Buffers<CR>

  nnoremap <silent> <Leader>l :BLines<CR>
  nnoremap <silent> <Leader>L :Lines<CR>

  nnoremap <silent> <Leader>c :BCommits<CR>
  nnoremap <silent> <Leader>C :Commits<CR>

  nnoremap <silent> <Leader>r :Rg<CR>
endif

if get(g:, 'coc_enabled', 0)
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
  xmap <silent><Space>f  <Plug>(coc-format-selected)
  nmap <silent><Space>f  <Plug>(coc-format)

  " Applying codeAction to the selected region.
  nmap <silent><Space>a  <Plug>(coc-codeaction-selected)
  xmap <silent><Space>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <silent><Space>ac  <Plug>(coc-codeaction)

  " Apply AutoFix to problem on the current line.
  nmap <Space>q  <Plug>(coc-fix-current)
  xmap <Space>q  :CocFix<CR>

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  if has('nvim-0.4.0') || has('patch-8.2.0750')
    " Ctrl-f Ctrl-b"
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

    " Ctrl-d Ctrl-u"
    nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
    nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
    inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
    vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
  end

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait><space>d  :<C-u>CocList -A diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  " nnoremap <silent><nowait> <space>j  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

  " Range Hover
  vnoremap <silent> K <cmd>call CocActionAsync('doHover')<CR>

  """""""""""""""""""""""""""""""""""""""""""""""""
  " coc-snippets
  """""""""""""""""""""""""""""""""""""""""""""""""
  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#confirm() :
      \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


  inoremap <expr><S-TAB> coc#pum#visible() ? "coc#pum#prev(1) : "\<C-h>"

  inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction



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

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <C-Space> coc#refresh()

  """""""""""""""""""""""""""""""""""""""""""""""""
  " coc-explorer
  """""""""""""""""""""""""""""""""""""""""""""""""
  nmap <Space>n :CocCommand explorer<CR>

  "----------------------------------------------------
  " coc-translator
  "----------------------------------------------------
  nmap <Leader>t <Plug>(coc-translator-p)
  vmap <Leader>t <Plug>(coc-translator-pv)
endif
