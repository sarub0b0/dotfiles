return {
  "SirVer/ultisnips",
  "honza/vim-snippets",
  {
    "L3MON4D3/LuaSnip",
    version = "V2.*",
    build = 'nix-shell -p luajit --run "make install_jsregexp"',
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()

      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/dotfiles/nvim/vsnip" } })

      require("luasnip").filetype_extend("ruby", { "rails" })

      require("luasnip").filetype_extend("all", { "_" })

      local types = require("luasnip.util.types")
      require("luasnip").config.setup({
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
          },
        },
      })
    end,
  },
  "rafamadriz/friendly-snippets",
  {
    "smjonas/snippet-converter.nvim",
    opts = {
      templates = {
        sources = {
          ultisnips = {
            "~/dotfiles/vim/snippets",
          },
        },
        output = {
          vscode_luasnip = {
            "~/dotfiles/nvim/vsnip",
          },
        },
      },
    },
  },
}
