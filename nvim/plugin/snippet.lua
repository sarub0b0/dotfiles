--
-- luasnip
--
require('luasnip.loaders.from_snipmate').lazy_load()

require("luasnip.loaders.from_vscode").lazy_load({ paths = { '~/dotfiles/nvim/vsnip' } })

require 'luasnip'.filetype_extend("ruby", { "rails" })

require 'luasnip'.filetype_extend("all", { "_" })

local types = require("luasnip.util.types")
require 'luasnip'.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } }
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "GruvboxBlue" } }
      }
    }
  },
})


--
-- snippet_converter
--
local template = {
  sources = {
    ultisnips = {
      "~/dotfiles/vim/snippets",
    },
  },
  output = {
    -- Specify the output formats and paths
    vscode_luasnip = {
      "~/dotfiles/nvim/vsnip",
    },
  },
}

require("snippet_converter").setup {
  templates = { template },
  -- To change the default settings (see configuration section in the documentation)
  -- settings = {},
}
