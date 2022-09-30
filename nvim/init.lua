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


vim.g.augroup_names = {
  my_auto_cmds = 'MyAutoCmds',
  my_filetypes = 'MyFileTypes'
}

for _, v in pairs(vim.g.augroup_names) do
  vim.api.nvim_create_augroup(v, {})
end

vim.cmd [[packadd packer.nvim]]
vim.opt.runtimepath:prepend { '~/dotfiles/nvim' }

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }

  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use 'jose-elias-alvarez/null-ls.nvim'

  use 'simrat39/rust-tools.nvim'

  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
  }

  use 'RRethy/nvim-treesitter-endwise'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'dmitmel/cmp-cmdline-history'
  use 'davidsierradz/cmp-conventionalcommits'

  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use {
    'L3MON4D3/LuaSnip',
    run = 'make install_jsregexp',
  }
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

  use 'f3fora/cmp-spell'
  use 'onsails/lspkind.nvim'
  use 'hrsh7th/nvim-cmp'

  use 'windwp/nvim-autopairs'

  use 'mhartington/oceanic-next'

  use 'voldikss/vim-floaterm'

  use 'liuchengxu/vista.vim'

  use 'nvim-treesitter/nvim-treesitter'
  use 'p00f/nvim-ts-rainbow'
  use 'romgrk/nvim-treesitter-context'

  use 'mvllow/modes.nvim'


  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use "nvim-lua/plenary.nvim"
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  use 'kyazdani42/nvim-web-devicons'

  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use 'itchyny/lightline.vim'

  use 'mfussenegger/nvim-dap'

  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }

  use 'numToStr/Comment.nvim'

  use 'kana/vim-submode'

  use {
    'vim-jp/vimdoc-ja',
    ft = { 'help' },
    opt = true,
  }

  -- git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- snippet
  use "smjonas/snippet-converter.nvim"

  use 'voldikss/vim-translator'

end)


vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')
