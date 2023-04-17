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
  automatic_installation = false,
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
require('lsp/clangd')

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
  extra_args = { '--config', '~/dotfiles/cspell/cspell.json' },
  config = {
    create_config_file = false,
    find_json = function()
      return vim.fn.expand("~/dotfiles/cspell/cspell.json")
    end
  }
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
  ensure_installed = {},
  automatic_installation = true,
  automatic_setup = true,
})
