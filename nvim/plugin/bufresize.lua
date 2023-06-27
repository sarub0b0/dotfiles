local ok, _ = pcall(require, 'bufresize')
if not ok then
  print 'bufresize is not installed.'
  return
end

local opts = { noremap = true, silent = true }
require('bufresize').setup({
  register = {
    keys = {
      { "n", "s<",            "<C-w><",             opts },
      { "n", "s>",            "<C-w>>",             opts },
      { "n", "s+",            "<C-w>+",             opts },
      { "n", "s-",            "<C-w>-",             opts },
      { "n", "ss",            "<C-w>_",             opts },
      { "n", "s=",            "<C-w>=",             opts },
      { "n", "sv",            "<C-w>|",             opts },
      { "",  "<LeftRelease>", "<LeftRelease>",      opts },
      { "i", "<LeftRelease>", "<LeftRelease><C-o>", opts },
    },
    trigger_events = { "BufWinEnter", "WinEnter" },
  },
  resize = {
    keys = {},
    trigger_events = { "VimResized" },
    increment = false,
  },
})
