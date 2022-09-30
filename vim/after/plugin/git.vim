function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

autocmd MyAutoCmd BufEnter * let b:git_dir = s:find_git_root() . '/.git'
