-- ------------------------------------------------
-- プロジェクト固有の設定をロードする
-- ------------------------------------------------

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    local files = vim.fs.find('.vimrc', { type = 'file', limit = math.huge })
    for _, file in pairs(files) do
      vim.cmd.source(file)
    end
  end,
  group = vim.g.augroup_names.my_filetypes
})
