-- ------------------------------------------------
-- プロジェクト固有の設定をロードする
-- ------------------------------------------------


vim.api.nvim_create_augroup('LocalVimrc', {})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    local files = { '.vimrc.local', '.vimrc.local.lua' }
    for _, file in ipairs(files) do
      if vim.fn.filereadable(file) == 1 then
        vim.cmd.source(file)
      end
    end
  end,
  group = 'LocalVimrc'
})
