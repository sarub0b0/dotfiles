return {
  {
    "vim-jp/vimdoc-ja",
    ft = { "help" },
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyUpdatePre",
        group = vim.api.nvim_create_augroup("lazy-update-pre", {}),
        callback = function()
          local vimdoc_repo = require("lazy.core.config").plugins["vimdoc-ja"].dir

          vim.system({ "git", "reset", "--hard" }, { cwd = vimdoc_repo }, function(info)
            if info.code == 0 then
              vim.schedule(function()
                require('fidget').notify("SUCCESS: vimdoc-ja reset to HEAD", vim.log.levels.INFO)
              end)
            else
              vim.schedule(function()
                require('fidget').notify("FAILED: vimdoc-ja reset to HEAD", vim.log.levels.ERROR)
              end)
            end
          end):wait()
        end,
      })
    end
  },
}
