scriptencoding utf-8

augroup MyAutoCmd
  autocmd!

  augroup DeleteLineEndSpaceCmd
    autocmd!
  augroup END
augroup END

if has('mac')
  let g:python_host_prog = expand('$PYENV_ROOT/versions/2.7.18/bin/python2')
  let g:python3_host_prog = expand('$PYENV_ROOT/versions/3.8.3/bin/python3')
else
  let g:python_host_prog = expand('$PYENV_ROOT/versions/2.7.18/bin/python')
  let g:python3_host_prog = expand('$PYENV_ROOT/versions/3.8.3/bin/python')
endif



" -----------------------------
" dein settings
" -----------------------------
if has('nvim')
  if filereadable(expand("$HOME/.dein_update_token.vim"))
    source $HOME/.dein_update_token.vim
  endif

  let g:dein#install_process_timeout = 240
  let s:dein_dir = ''

  let g:config_dir = expand('$HOME/.vim')
  let g:cache_dir = expand('$HOME/.cache/vim')
  if has('nvim')
    let g:config_dir = expand('$HOME/.config/nvim')
    let g:cache_dir = expand('$HOME/.cache/nvim')
  endif

  let s:dein_dir = g:cache_dir . '/dein'

  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir


  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir  = g:config_dir . '/dein'

    let s:toml = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    let s:syntax_toml = s:toml_dir . '/syntax.toml'
    let s:dev_toml = s:toml_dir . '/dev.toml'
    let s:text_toml = s:toml_dir . '/text.toml'
    let s:help_toml = s:toml_dir . '/help.toml'

    call dein#load_toml(s:toml, {'lazy': 0})

    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#load_toml(s:dev_toml, {'lazy': 1})
    call dein#load_toml(s:syntax_toml, {'lazy': 1})
    call dein#load_toml(s:text_toml, {'lazy': 1})
    call dein#load_toml(s:help_toml, {'lazy': 1})

    if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#end()
    call dein#save_state()
  endif

  filetype plugin indent on
  syntax enable

  if dein#check_install()
    call dein#install()
  endif
endif
