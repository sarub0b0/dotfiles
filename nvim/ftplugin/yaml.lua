if vim.b.my_did_ftplugin then
  return
end
vim.b.my_did_ftplugin = 1

vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemaStore = {
        enable = true
      },
      schemas = {
        kubernetes = {
          "manifest*/**/*.yaml",
          "/*.yaml"
        },
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
          "/**/.gitlab-ci.yml",
          "/**/.gitlab/*.y*ml"
        }
      },
    },
  }
}