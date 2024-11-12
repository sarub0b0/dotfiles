vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.skip_loading_mswin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spellfile_plugin = 1

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

vim.g.augroup_names = {
  my_auto_cmds = 'MyAutoCmds',
}

for _, v in pairs(vim.g.augroup_names) do
  vim.api.nvim_create_augroup(v, {})
end

if vim.fn.filereadable(vim.fn.expand('~/.local/share/cspell/vim.txt.gz')) == 0 then
  local vim_dictionary_url = 'https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz'
  local cmd = { 'curl', '-fsSLo', vim.fn.expand('~/.local/share/cspell/vim.txt.gz'), '--create-dirs', vim_dictionary_url }
  io.popen(table.concat(cmd, ' '))

  print('Downloaded cspell vim dictionary.')
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  spec = {
    import = "plugins"
  },
  ui = {
    border = "single"
  }
})

vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')
