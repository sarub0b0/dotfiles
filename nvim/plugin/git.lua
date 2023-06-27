local ok, _ = pcall(require, 'gitsigns')
if not ok then
  print 'gitsigns is not installed.'
  return
end

--
-- gitsigns
--
-- TODO: 透過用のハイライトを設定する
require('gitsigns').setup({
  signcolumn = true,
  numhl = true,
  current_line_blame_opts = {
    delay = 300,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>gS', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gb', function() gs.blame_line { full = true } end)
    map('n', '<leader>gtb', gs.toggle_current_line_blame)
    map('n', '<leader>gd', gs.diffthis)
    map('n', '<leader>gD', function() gs.diffthis('~') end)
    map('n', '<leader>gtd', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

--
-- fugitive
--
vim.g.fugitive_no_maps = 0

vim.keymap.set('n', '<Space>g', '<Cmd>G<CR>', { noremap = true, silent = true })
-- vim.api.nvim_create_autocmd({ 'WinEnter' }, {
--   pattern = '*',
--   callback = function()
--     if vim.b.git_dir then
--       vim.g.git_dir = vim.b.git_dir
--     end
--   end,
--   group = vim.g.augroup_names.my_auto_cmds
-- })
-- let g:fugitive_no_maps = 0
--
-- autocmd MyAutoCmd WinEnter * if exists('b:git_dir') | let g:git_dir = b:git_dir | endif
--
-- autocmd MyAutoCmd BufRead,BufNewFile * if exists('g:git_dir') | let b:git_dir = g:git_dir | endif
--
local function modify_highlight_transparent_bg_color(group_name)
  local gui = vim.api.nvim_get_hl_by_name(group_name, true)
  local cterm = vim.api.nvim_get_hl_by_name(group_name, false)
  local ctermfg = cterm.foreground
  local ctermbg = nil

  gui.background = nil
  cterm.foreground = nil
  cterm.background = nil

  local hl_value = vim.tbl_extend('error', gui, {
    ctermfg = ctermfg,
    ctermbg = ctermbg,
    cterm = cterm
  })

  vim.api.nvim_set_hl(0, group_name, hl_value)
end
