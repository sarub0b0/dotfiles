vim.api.nvim_create_user_command('LspInlayHintsToggle',
  function(_opts)
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end,
  {}
)
