return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      local ensureInstalled = {
        "markdown",
        "markdown_inline",
        "yaml",
        "c",
        "lua",
        "rust",
        "json",
        "gitcommit",
        "gitignore",
        "gitattributes",
        "git_rebase",
        "git_config",
        "diff"
      }
      local alreadyInstalled = require('nvim-treesitter').get_installed({})
      local parsersToInstall = vim.iter(ensureInstalled)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
      require('nvim-treesitter').install(parsersToInstall)
    end,
    opts = {
      sync_install = true,
      endwise = {
        enable = true,
      },
    },
  },
  "nvim-treesitter/nvim-treesitter-context",
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
      languages = {
        javascript = {
          __default = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          jsx_attribute = "// %s",
          comment = "// %s",
        },
        typescript = {
          __default = "// %s",
          __multiline = "/* %s */",
        },
        eruby = { __default = "<%= begin %> %s <%= end %>", __multiline = "<%= begin %> %s <%= end %>" },
      },
      not_nested_languages = {
        eruby = true,
      },
    },
  },
  "RRethy/nvim-treesitter-endwise",
}
