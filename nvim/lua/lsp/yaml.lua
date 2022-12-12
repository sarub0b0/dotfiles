require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemas = {
        kubernetes = {
          "manifest*/**/*.yaml",
          "/*.k8s.yaml"
        },
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
          "/**/.gitlab-ci.yml",
          "/**/.gitlab/*.y*ml"
        },
        ["https://raw.githubusercontent.com/loft-sh/devspace/main/devspace-schema.json"] = {
          "/**/devspace*.yaml"
        },
      },
    },
  }
}
