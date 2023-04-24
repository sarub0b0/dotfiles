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


local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

if not packer_bootstrap then
  vim.opt.runtimepath:append { '~/dotfiles/nvim' }
end

require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
    use "nvim-lua/plenary.nvim"

    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
    }
    use "jayp0521/mason-null-ls.nvim"

    use 'simrat39/rust-tools.nvim'

    use {
      "glepnir/lspsaga.nvim",
      branch = "main",
      opt = true,
      event = "LspAttach",
      requires = {
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter/nvim-treesitter"
      },
      config = require('lazy/lspsaga').setup
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
      run = 'nix-shell -p luajit --run "make install_jsregexp"',
    }
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"

    use 'f3fora/cmp-spell'
    use 'onsails/lspkind.nvim'
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
        'davidsierradz/cmp-conventionalcommits',
        'saadparwaiz1/cmp_luasnip',
      }
    }

    use 'windwp/nvim-autopairs'

    -- use 'mhartington/oceanic-next'
    use 'adrian5/oceanic-next-vim'
    use 'voldikss/vim-floaterm'

    use 'liuchengxu/vista.vim'

    use { 'nvim-treesitter/nvim-treesitter' }

    use 'romgrk/nvim-treesitter-context'

    use 'windwp/nvim-ts-autotag'

    use 'mvllow/modes.nvim'


    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'nvim-telescope/telescope-ghq.nvim'
    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ghq.nvim'
      },
    }

    use 'nvim-tree/nvim-web-devicons'
    use {
      'akinsho/bufferline.nvim',
      tag = "v3.*",
      requires = 'nvim-tree/nvim-web-devicons',
    }

    use 'itchyny/lightline.vim'

    use 'mfussenegger/nvim-dap'

    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/vim-easy-align' }

    -- ホームディレクトリなどファイル数が多いディレクトリのとき
    -- 起動が遅いため遅延読み込みにする
    use {
      'nvim-tree/nvim-tree.lua',
      requires = 'nvim-tree/nvim-web-devicons',
    }

    use 'numToStr/Comment.nvim'
    use 'JoosepAlviste/nvim-ts-context-commentstring'

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

    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
    }

    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use 'aklt/plantuml-syntax'

    use "LudoPinelli/comment-box.nvim"

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})


vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')
