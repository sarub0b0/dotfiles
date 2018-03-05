scriptencoding utf-8

" -----------------------------
" dein settings
" -----------------------------
if &compatible
    set nocompatible
endif


let g:config_dir = expand('$HOME/dotfiles/vim')
let g:cache_dir = ''
let s:dein_dir = ''

let g:cache_dir = expand('$HOME/.cache/vim')
if has('nvim')
    let g:cache_dir = expand('$HOME/.cache/nvim')
endif
if has('gui_running') || has('gui_macvim')
    let g:cache_dir = expand('$HOME/.cache/gvim')
endif

let s:dein_dir = g:cache_dir . '/dein'

" dein.vimのディレクトリ
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir


if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_dir  = g:config_dir . '/rc/toml'

    " 管理するプラグインを記述したファイル
    let s:toml = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    let s:syntax_toml = s:toml_dir . '/syntax.toml'
    let s:dev_toml = s:toml_dir . '/dev.toml'
    let s:text_toml = s:toml_dir . '/text.toml'
    let s:code_toml = s:toml_dir . '/code.toml'
    let s:tex_toml = s:toml_dir . '/tex.toml'
    let s:help_toml = s:toml_dir . '/help.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})


    call dein#load_toml(s:dev_toml, {'lazy': 1})
    call dein#load_toml(s:syntax_toml, {'lazy': 1})

    call dein#load_toml(s:code_toml, {'lazy': 1})
    call dein#load_toml(s:tex_toml, {'lazy': 1})
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

if dein#check_install()
    call dein#install()
endif
