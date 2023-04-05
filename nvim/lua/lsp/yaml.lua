require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      schemas = {
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
          "/**/.gitlab-ci.yml",
          "/**/.gitlab/*.y*ml"
        },
        ["https://raw.githubusercontent.com/loft-sh/devspace/main/devspace-schema.json"] = {
          "/**/devspace*.yaml"
        },
        ["https://json.schemastore.org/kustomization.json"] = {
          "/**/kustomization.yaml"
        },
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json"] = {
          "manifest*/**/*.yaml",
          "/*.k8s.yaml",
          "*.yaml"
        },
      },
    },
  }
}
