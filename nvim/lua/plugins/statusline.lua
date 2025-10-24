return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "cenk1cenk2/schema-companion.nvim",
    },
    opts = {
      options = {
        theme = "OceanicNext",
      },
      extensions = {
        "fugitive",
        "fzf",
        "man",
        "neo-tree",
        "quickfix",
        "trouble",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            symbols = {
              readonly = "",
            },
          },
          {
            "yaml schema",
            fmt = function()
              return ("%s %s")
                :format(nvim.ui.icons.ui.Table, require("schema-companion").get_current_schemas() or "none")
                :sub(0, 128)
            end,
            cond = function()
              return package.loaded["schema-companion"]
            end,
          },
        },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location", "searchcount", "selectioncount" },
      },
    },
  },
}
