function! s:open_terminal(...) abort
  let l:open_type = 'new'
  let l:shell = &shell
  let l:path = getcwd()

  if a:0 > 0 && a:0 !=# ''
    let l:open_type = a:1
  endif
  if a:0 > 1 && a:2 !=# ''
    let l:path = a:2
  endif
  if a:0 > 2 && a:3 !=# ''
    let l:shell = a:3
  endif

  if l:open_type ==# 'new'
    let l:open_type = 'bo ' .. l:open_type
  endif

  exe printf('%s | lcd %s', l:open_type, l:path)
  call termopen([l:shell], {'on_exit': function('s:on_exit')})
endfunction

function! s:on_exit(job_id, data, event) dict
  call feedkeys('\<CR>')
endfunction

command! -nargs=* OpenTerminal call s:open_terminal(<f-args>)

function! s:cd_repo(shell, repo) abort
  exe 'lcd' trim(system('ghq root')) .. '/' .. a:repo
  call s:open_terminal('new', '', a:shell)
  exe 'wincmd k'
  pwd
endfunction

function! s:repo(multi, cb) abort
  if executable('ghq') && exists('*fzf#run()') && executable('fzf')
    call fzf#run({
        \ 'source': systemlist('ghq list'),
        \ 'sink': a:cb,
        \ 'options': a:multi,
        \ 'down': '20%'},
        \ )
  else
    echo "doesn't installed ghq or fzf.vim (require fzf)"
  endif
endfunction

command! Repo call s:repo('+m', function('s:cd_repo', [&shell]))
