return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = "nvim-lua/plenary.nvim",
    keys = function()
      return {
        { "<leader>ff", require("telescope.builtin").find_files },
        { "<leader>fg", require("telescope.builtin").live_grep },
        { "<leader>fb", require("telescope.builtin").buffers },
        { "<leader>fh", require("telescope.builtin").help_tags },
        { "<leader>fd", require("telescope.builtin").diagnostics },
      }
    end,
  },
}
