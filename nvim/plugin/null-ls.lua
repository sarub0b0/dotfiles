local augroup = vim.api.nvim_create_augroup("NullLsFormatting", {})
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.formatting.buf,
    null_ls.builtins.diagnostics.cspell.with({
      disabled_filetypes = { 'NvimTree' },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.WARN
      end,
      condition = function()
        return vim.fn.executable('cspell') > 0
      end,
      extra_args = { '--config', '~/dotfiles/cspell/cspell.yaml' }
    }),
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
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,

})
