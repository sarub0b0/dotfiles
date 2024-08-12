if vim.b.my_did_ftplugin then
  return
end
vim.b.my_did_ftplugin = 1

-- :help hex-editing
-- augroup Binary
--   au!
--   au BufReadPre  *.bin let &bin=1
--   au BufReadPost *.bin if &bin | %!xxd
--   au BufReadPost *.bin set ft=xxd | endif
--   au BufWritePre *.bin if &bin | %!xxd -r
--   au BufWritePre *.bin endif
--   au BufWritePost *.bin if &bin | %!xxd
--   au BufWritePost *.bin set nomod | endif
-- augroup END

local pattern = '*'
local group = 'Binary'
vim.api.nvim_create_augroup(group, {})
vim.api.nvim_create_autocmd({ 'Filetype' }, {
  group = group,
  pattern = 'binary',
  callback = function()
    vim.b.bin = 1
  end
})
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  group = group,
  pattern = pattern,
  callback = function()
    if vim.b.bin == 1 then
      vim.cmd [[%!xxd]]
      vim.opt_local.filetype = 'xxd'
    end
  end
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = group,
  pattern = pattern,
  callback = function()
    if vim.b.bin == 1 then
      vim.cmd [[%!xxd -r]]
    end
  end
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = group,
  pattern = pattern,
  callback = function()
    if vim.b.bin == 1 then
      vim.cmd [[%!xxd]]
      vim.opt_local.modified = false
    end
  end
})
