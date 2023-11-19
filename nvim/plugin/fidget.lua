local ok, _ = pcall(require, 'fidget')
if not ok then
  print 'fidget is not installed.'
  return
end

require('fidget').setup({
  progress = {
    lsp = {
      progress_ringbuf_size = 1024,
    }
  },
  notification = {
    window = {
      winblend = 0, -- &winblend for the window
    },
  },
})
