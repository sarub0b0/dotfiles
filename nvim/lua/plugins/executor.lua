return {
  {
    "google/executor.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    opts = {
      use_split = false,
      notifications = {
        task_started = true,
        task_completed = true,
      },
      preset_commands = {
        ["kubetui"] = {
          "cargo clippy",
          "cargo test --tests",
        },
      },
    },
    keys = {
      {
        "<leader>er",
        function()
          require("executor").commands.run()
        end,
      },
      {
        "<leader>es",
        function()
          require("executor").commands.set_command()
        end,
      },
      {
        "<leader>ev",
        function()
          require("executor").commands.toggle_detail()
        end,
      },
      {
        "<leader>ep",
        function()
          require("executor").commands.show_presets()
        end,
      },
    },
  },
}
