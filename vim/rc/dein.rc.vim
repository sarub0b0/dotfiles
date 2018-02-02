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
" dein.vim�Υǥ��쥯�ȥ�
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" �ʤ����git clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)


  " ��������ץ饰����򵭽Ҥ����ե�����
  let s:toml = g:config_dir . '/rc/dein.toml'
  let s:lazy_toml = g:config_dir . '/rc/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" �ץ饰������ɲá������toml�ե������������ѹ��������
" Ŭ�� call dein#update �� call dein#clear_state ��Ƥ�Ǥ���������
" ���⤽�⥭��å��夷�ʤ����ɤ��ʤ�load_state/save_state��ƤФʤ��褦�ˤ��Ƥ���������

" 2016.04.16 �ɵ�
" load_cache -> load_state
" save_cache -> save_state
" �Ȥʤ�����������Ѥ��ޤ�����
" �ɵ������

" vimproc�����Ϻǽ�˥��󥹥ȡ��뤷�Ƥۤ���
if dein#check_install(['vimproc.vim'])
  call dein#install(['vimproc.vim'])
endif
" ����¾���󥹥ȡ��뤷�Ƥ��ʤ���ΤϤ�����������
if dein#check_install()
  call dein#install()
endif
