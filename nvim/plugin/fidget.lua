local ok, _ = pcall(require, 'fidget')
if not ok then
  print 'fidget is not installed.'
  return
end

require('fidget').setup({
  text = {
    spinner = "dots", -- animation shown when tasks are ongoing
  },
  window = {
    blend = 0, -- &winblend for the window
  },
})
