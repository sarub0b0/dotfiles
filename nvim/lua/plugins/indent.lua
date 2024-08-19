return {
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = function(_, opts)
  --     require("ibl").setup(opts)
  --
  --     local hooks = require("ibl.hooks")
  --
  --     hooks.register(
  --       hooks.type.WHITESPACE,
  --       hooks.builtin.hide_first_space_indent_level
  --     )
  --
  --     hooks.register(
  --       hooks.type.WHITESPACE,
  --       hooks.builtin.hide_first_tab_indent_level
  --     )
  --   end,
  --   opts = {
  --     enabled = true,
  --     indent = {
  --       char = '│',
  --       highlight = { 'VertSplit' }
  --     },
  --     scope = {
  --       enabled = true
  --     }
  --   }
  -- },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true
        },
        indent = {
          enable = true,
          style = { vim.api.nvim_get_hl(0, { name = "VertSplit" }) },
          filter_list = {
            function(v)
              return v.level ~= 1
            end
          }

        },
        blank = {
          enable = false
        },
        line_num = {
          enable = true
        }
      })
    end
  }
}
