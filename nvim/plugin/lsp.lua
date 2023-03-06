require('mason').setup()
require('mason-lspconfig').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = 'utf-8'

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end


require('mason-lspconfig').setup({
  ensure_installed = {},
  automatic_installation = true,
})
require('mason-lspconfig').setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
})

require('lsp/rust')
require('lsp/yaml')

vim.keymap.set(
  'n',
  '<Space>f',
  function()
    local view = vim.fn.winsaveview()
    vim.lsp.buf.format { async = false }
    vim.fn.winrestview(view)
  end,
  { noremap = true, silent = true }
)

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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = {
    source = "always", -- Or "if_many"
  },
  float = {
    source = "always", -- Or "if_many"
  },
})


-- null-ls
local augroup = vim.api.nvim_create_augroup("NullLsFormatting", {})
local null_ls = require('null-ls')

local cspell_with = {
  disabled_filetypes = { 'NvimTree' },
  diagnostics_postprocess = function(diagnostic)
    diagnostic.severity = vim.diagnostic.severity.WARN
  end,
  condition = function()
    return vim.fn.executable('cspell') > 0
  end,
}

null_ls.setup({
  sources = {
    -- null_ls.builtins.code_actions.gitsigns,

    null_ls.builtins.formatting.clang_format,

    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.formatting.buf,

    null_ls.builtins.diagnostics.cspell.with(cspell_with),
    null_ls.builtins.code_actions.cspell.with(cspell_with),

    null_ls.builtins.diagnostics.hadolint,

    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,

    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,

    null_ls.builtins.formatting.terraform_fmt,

    null_ls.builtins.formatting.shfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          local view = vim.fn.winsaveview()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
          vim.fn.winrestview(view)
        end,
      })
    end
  end,
})

require("mason-null-ls").setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = true,
})
