local M = {
  setup = function()
    require('nvim-tree').setup({
      view = {
        adaptive_size = true,
        mappings = {
          list = {
            { key = 's', action = '' },
            { key = 'u', action = 'dir_up' },
            { key = 'o', action = 'system_open' },
          }
        },
      },
      filters = {
        dotfiles = true
      },
      git = {
        ignore = false
      }
    })

  end
}

return M
