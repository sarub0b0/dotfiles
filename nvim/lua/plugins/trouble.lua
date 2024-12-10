return {
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "Trouble",
    opts = {
      auto_close = false,
    },
    keys = {
      {
        "<leader>xx",
        "<Cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer Diagnostics (Trouble)",
      },

      {
        "<leader>cs",
        "<Cmd>Trouble symbols toggle focus=false<CR>",
        desc = "Symbols (Trouble)",
      },

      {
        "<leader>cl",
        "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },

      {
        "<leader>xL",
        "<Cmd>Trouble loclist toggle<CR>",
        desc = "Location List (Trouble)",
      },

      {
        "<leader>xQ",
        "<Cmd>Trouble qflist toggle<CR>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "<leader>xn",
        function()
          require("trouble").next({ jump = true })
        end,
        desc = "Next Trouble",
      },
      {
        "<leader>xp",
        function()
          require("trouble").prev({ jump = true })
        end,
        desc = "Previous Trouble",
      },
    },
  },
}
