return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      ensure_installed = {
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
        "diff",
      },
      sync_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
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
    opts = {}
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
      },
    },
  },
  "RRethy/nvim-treesitter-endwise",
}
