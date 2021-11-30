scriptencoding utf-8

let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1
let g:skip_loading_mswin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_remote_plugins = 1
let g:loaded_shada_plugin = 1
let g:loaded_gzip = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_tar = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_spellfile_plugin = 1

if has('win32') || has('win64')
  let &shell = has('win32') ? 'powershell' : 'pwsh'
  let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  set shellquote= shellxquote=
endif

augroup MyAutoCmd
  autocmd!

  augroup DeleteLineEndSpaceCmd
    autocmd!
  augroup END
augroup END

if !exists('g:vscode')

  if has('mac')
    let g:python_host_prog = expand('$PYENV_ROOT/versions/2.7.18/bin/python2')
    let g:python3_host_prog = expand('$PYENV_ROOT/versions/3.9.7/bin/python3')
  elseif has('win32') || has('win64')
    let g:python_host_prog = expand('$HOME/scoop/apps/python27/current/python.exe')
    let g:python3_host_prog = expand('$HOME/scoop/apps/python39/current/python.exe')
  elseif has('unix')
    let g:python_host_prog = expand('$PYENV_ROOT/versions/2.7.18/bin/python')
    let g:python3_host_prog = expand('$PYENV_ROOT/versions/3.9.7/bin/python')
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
      execute '!git clone --depth 1 https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
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
endif
