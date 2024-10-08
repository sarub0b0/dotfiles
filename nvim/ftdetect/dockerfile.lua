vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { 'Dockerfile*', 'dockerfile*' },
  callback = function()
    local filename = vim.fn.expand('%:t')
    if filename == 'dockerfile.lua' or filename == 'dockerfile.vim' then
      return
    end

    vim.opt_local.filetype = 'dockerfile'
  end,
  group = 'filetypedetect'
})
