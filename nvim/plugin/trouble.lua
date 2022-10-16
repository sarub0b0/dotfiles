require("trouble").setup({
  auto_close = true,
})

vim.keymap.set('n', '<Space>t', '<Cmd>TroubleToggle<CR>', { noremap = true, silent = true })
