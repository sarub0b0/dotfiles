return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function(_, opts)
      require("ibl").setup(opts)

      local hooks = require("ibl.hooks")

      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level
      )

      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_tab_indent_level
      )
    end,
    opts = {
      enabled = true,
      indent = {
        char = '│',
        highlight = { 'VertSplit' }
      },
      scope = {
        enabled = true
      }
    }
  }
}
