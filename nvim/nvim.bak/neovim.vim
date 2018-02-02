let s:config_dir = expand($XDG_CONFIG_HOME)
let g:plugin_fir = s:config_dir . '/nvim/neovim/'
let g:python_host_prog = expand("$PYENV_ROOT/versions/2.7.14/bin/python")
let g:python3_host_prog = expand("$PYENV_ROOT/versions/3.6.4/bin/python")

execute 'source' . s:config_dir . '/nvim/neovim/dein.vim'

execute 'source' . s:config_dir . '/nvim/neovim/config.vim'

" execute 'source' . s:config_dir . '/nvim/neovim/color.vim'

" execute 'source' . s:config_dir . '/nvim/neovim/vim-latex.vim'

" execute 'source' . s:config_dir . '/nvim/neovim/nerdcommenter.vim'

" execute 'source' . s:config_dir . '/nvim/neovim/tagbar.vim'

" execute 'source' . s:config_dir . '/nvim/neovim/ale.vim'

" execute 'source' . s:config_dir . '/nvim/neovim/quickrun.vim'
" execute 'source' . s:config_dir . '/nvim/neovim/airline.vim'
