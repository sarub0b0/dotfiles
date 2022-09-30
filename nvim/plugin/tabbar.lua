-- vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
vim.g.vista_echo_cursor = 0
vim.g.vista_sidebar_width = 40
vim.g['vista#renderer#enable_icon'] = 1
vim.g.vista_default_executive = 'nvim_lsp'
vim.keymap.set('n', '<Space>t', ':<C-u>Vista!!<CR>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd(
  {
    "FileType"
  },
  {
    pattern = { "vista", "vista_kind" },
    command = 'nnoremap <buffer><silent> / :<c-u>call vista#finder#fzf#Run()<CR>',
    group = vim.g.augroup_names.my_auto_cmds
  }
)
