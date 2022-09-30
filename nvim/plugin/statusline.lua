vim.cmd [[
  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction
]]

vim.g.lightline = {
  colorscheme        = 'oceanicnext',
  active             = {
    left = {
      { 'mode', 'paste' },
      { 'readonly', 'filename', 'modified', 'method' },
    }
  },
  component_function = {
    method = 'NearestMethodOrFunction'
  }
}
