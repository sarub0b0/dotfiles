local M = {
  setup = function()
    -- lspsaga
    require("lspsaga").setup({
      -- your configuration
      scroll_preview = {
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
      },
      move_in_saga = { prev = '<C-p>', next = '<C-n>' },
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        separator = ' ▶︎ ',
      },
      ui = {
        -- currently only round theme
        theme = 'round',
        -- this option only work in neovim 0.9
        title = true,
        -- border type can be single,double,rounded,solid,shadow.
        border = 'single',
        winblend = 0,
        expand = '▶︎ ',
        collapse = ' ',
        preview = ' ',
        code_action = '💡',
        diagnostic = '🐞',
        incoming = ' ',
        outgoing = ' ',
        colors = {
          --float window normal background color
          normal_bg = '#1b2b34',
          --title background color
          title_bg = '#65737e',
          red = '#ec5f67',
          magenta = '#c594c5',
          orange = '#f99157',
          yellow = '#fac863',
          green = '#99c794',
          cyan = '#62b3b2',
          blue = '#6699cc',
          purple = '#c594c5',
          white = '#ffffff',
          black = '#1c1c19',
        },
        kind = {},
      },
    })
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
    vim.keymap.set('n', 'gl', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<Space>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
    vim.keymap.set('n', '<Space>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
    vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', { silent = true })
    vim.keymap.set("n", "[g", function() require('lspsaga.diagnostic'):goto_prev() end, { silent = true })
    vim.keymap.set("n", "]g", function() require('lspsaga.diagnostic'):goto_next() end, { silent = true })

    vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
    vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })
    vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { silent = true })
    vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { silent = true })


    vim.keymap.set("n", "[G", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    vim.keymap.set("n", "]G", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
    -- vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    -- vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition)
    -- vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition)
    -- vim.keymap.set('n', '<Space>ca', vim.lsp.buf.code_action)
  end
}

return M
