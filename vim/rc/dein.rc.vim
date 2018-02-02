" -----------------------------
" dein settings
" -----------------------------

if has('nvim')
  let g:config_dir = expand('$HOME/dotfiles/vim')
  let g:cache_dir = expand('$HOME/.cache/nvim')
  let s:dein_dir = expand('~/.cache/nvim/dein')
endif
if has('vim')
  let g:config_dir = expand('$HOME/dotfiles/vim')
  let g:cache_dir = expand('$HOME/.cache/vim')
  let s:dein_dir = expand('~/.cache/vim/dein')
endif
if has('gui_macvim')
  let g:config_dir = expand('$HOME/dotfiles/vim')
  let g:cache_dir = expand('$HOME/.cache/gvim')
  let s:dein_dir = expand('~/.cache/gvim/dein')
endif
" dein.vimのディレクトリ
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)


  " 管理するプラグインを記述したファイル
  let s:toml = g:config_dir . '/rc/dein.toml'
  let s:lazy_toml = g:config_dir . '/rc/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。

" 2016.04.16 追記
" load_cache -> load_state
" save_cache -> save_state
" となり書き方が少し変わりました。
" 追記終わり

" vimprocだけは最初にインストールしてほしい
if dein#check_install(['vimproc.vim'])
  call dein#install(['vimproc.vim'])
endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif
