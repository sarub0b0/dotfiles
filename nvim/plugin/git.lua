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
  signcolumn              = true,
  numhl                   = true,
  linehl                  = true,
  word_diff               = true,
  current_line_blame_opts = {
    delay = 300,
  },
  on_attach               = function(bufnr)
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
    map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
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
