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
  extra_args = { '--config', vim.fn.expand('~/dotfiles/cspell/cspell.yaml') }

}

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,

    null_ls.builtins.formatting.clang_format,

    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.formatting.buf,

    null_ls.builtins.diagnostics.cspell.with(cspell_with),

    null_ls.builtins.diagnostics.hadolint,

    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(client)
              return client.name == 'null-ls'
            end
          })
        end,
      })
    end
  end,
})

local ok, _ = pcall(require, 'null-ls/cspell_suggestions')
if not ok then
  print('failed to load null-ls/cspell_suggestions.lua')
end

local ok, _ = pcall(require, 'null-ls/cspell_add_word')
if not ok then
  print('failed to load null-ls/cspell_add_word.lua')
end
