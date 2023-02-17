vim.cmd [[
  function! LightLineNearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  function! LightLineGitStatus() abort
    return get(b:, 'gitsigns_status', '')
  endfunction

  function! LightLineGitHead() abort
    return get(b:, 'gitsigns_head', '')
  endfunction

  function! LightLineReadonly()
      if &filetype == "help"
          return ""
      elseif &readonly
          return ""
      else
          return ""
      endif
  endfunction
]]

vim.g.lightline = {
  colorscheme        = 'oceanicnext',
  active             = {
    left = {
      { 'mode',      'paste' },
      { 'readonly',  'filename', 'modified' },
      { 'gitstatus', 'method' },
    }
  },
  component_function = {
    method = 'LightLineNearestMethodOrFunction',
    gitstatus = 'LightLineGitStatus',
    readonly = 'LightLineReadonly',
  },
  separator          = { left = '', right = '' },
  subseparator       = { left = '', right = '' },
  mode_map           = {
    n = 'N',
    i = 'I',
    R = 'R',
    v = 'V',
    V = 'VL',
    ['\\<C-v>'] = 'VB',
    c = 'C',
    s = 'S',
    S = 'SL',
    ['\\<C-s>'] = 'SB',
    t = 'T',
  },
  enable             = {
    tabline = 0,
  }
}
