if vim.b.my_did_ftplugin then
  return
end
vim.b.my_did_ftplugin = 1

vim.opt_local.textwidth = 0


local cmp = require('cmp')
cmp.setup.buffer({
  sources = cmp.config.sources({
    { name = 'conventionalcommits' }
  }, {
    { name = 'buffer' },
  })
})
