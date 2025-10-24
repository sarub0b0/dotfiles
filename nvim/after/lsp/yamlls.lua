-- your LSP file: ./after/lsp/yamlls.lua
return require("schema-companion").setup_client(
  require("schema-companion").adapters.yamlls.setup({
    sources = {
      -- your sources for the language server
      require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
      require("schema-companion").sources.lsp.setup(),
      require("schema-companion").sources.schemas.setup({
        {
          name = "Kubernetes master",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
        },
        -- {
        --   name = "GitLab CI",
        --   uri = "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json",
        -- },
        -- {
        --   name = "Kustomize",
        --   uri = "https://json.schemastore.org/kustomization.json",
        -- },
        -- {
        --   name = "DevSpace",
        --   uri = "https://raw.githubusercontent.com/loft-sh/devspace/main/devspace-schema.json",
        -- },
      }),
    },
  }),
  {
    --- your yaml language server configuration
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    settings = {
      yaml = {
        format = {
          enable = true,
        },
        schemas = {
          -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
          --   "/**/.gitlab-ci.yml",
          --   "/**/.gitlab/*.y*ml"
          -- },
          -- ["https://raw.githubusercontent.com/loft-sh/devspace/main/devspace-schema.json"] = {
          --   "/**/devspace*.yaml"
          -- },
          -- ["https://json.schemastore.org/kustomization.json"] = {
          --   "/**/kustomization.yaml"
          -- },
        },
        customTags = {
          "!reference sequence",
        },
        -- trace = {
        --   server = "debug"
        -- },
      },
    },
  }
)
