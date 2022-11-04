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
    null_ls.builtins.code_actions.cspell.with(cspell_with),

    null_ls.builtins.diagnostics.hadolint,

    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint,

    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rustfmt,
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

require('null-ls/cspell_add_word').setup()
