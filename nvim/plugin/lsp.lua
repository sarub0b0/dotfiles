require('mason').setup()
require('mason-lspconfig').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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


require('mason-lspconfig').setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
})



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

vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { silent = true })
vim.keymap.set('n', 'gl', '<cmd>Lspsaga lsp_finder<CR>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>ca', '<cmd>Lspsaga code_action<CR>', { silent = true })
vim.keymap.set('n', '<Space>rn', '<cmd>Lspsaga rename<CR>', { silent = true })
vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', { silent = true })
vim.keymap.set("n", "[g", function() require('lspsaga.diagnostic').goto_prev() end, { silent = true })
vim.keymap.set("n", "]g", function() require('lspsaga.diagnostic').goto_next() end, { silent = true })

vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })


vim.keymap.set("n", "[G", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
vim.keymap.set("n", "]G", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
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
