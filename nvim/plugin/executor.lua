local ok, _ = pcall(require, 'executor')
if not ok then
  print 'executor is not installed.'
  return
end

require('executor').setup({
  use_split = false,
  notifications = {
    task_started = true,
    task_completed = true,
  },
  preset_commands = {
    ["kubetui"] = {
      "cargo clippy",
      "cargo test --tests"
    }
  }
})

vim.api.nvim_set_keymap("n", "<leader>er", ":ExecutorRun<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>es", ":ExecutorSetCommand<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ev", ":ExecutorToggleDetail<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>ep", ":ExecutorShowPresets<CR>", {})
