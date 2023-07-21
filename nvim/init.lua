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

if vim.fn.filereadable('~/.local/share/cspell/vim.txt.gz') ~= 1 then
  local vim_dictionary_url = 'https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz'
  io.popen('curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs ' .. vim_dictionary_url)
end

local packer_bootstrap = ensure_packer()

if not packer_bootstrap then
end

vim.opt.runtimepath:append { '~/dotfiles/nvim' }
vim.opt.runtimepath:append { '~/dotfiles/nvim/after' }

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  if vim.fn.executable('pwsh') then
    vim.o.shell = 'pwsh'
  else
    vim.o.shell = 'powershell'
  end
  vim.o.shellcmdflag =
  '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.o.shellquote = nil
  vim.o.shellxquote = nil
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
      after = "nvim-lspconfig",
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

    use 'mhartington/oceanic-next'

    use 'voldikss/vim-floaterm'

    use 'liuchengxu/vista.vim'

    use 'nvim-treesitter/nvim-treesitter'

    use 'romgrk/nvim-treesitter-context'

    use { 'windwp/nvim-ts-autotag', requires = { 'nvim-treesitter/nvim-treesitter' } }

    use 'mvllow/modes.nvim'


    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'nvim-telescope/telescope-ghq.nvim'
    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.*',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ghq.nvim'
      },
    }

    use 'nvim-tree/nvim-web-devicons'
    use {
      'akinsho/bufferline.nvim',
      tag = "*",
      requires = 'nvim-tree/nvim-web-devicons',
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use 'mfussenegger/nvim-dap'

    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }
    use { 'junegunn/vim-easy-align' }

    use {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v2.x",
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        {
          's1n7ax/nvim-window-picker',
          tag = 'v1.*',
        }
      }
    }

    use "kwkarlwang/bufresize.nvim"

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


    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
    }

    use 'sindrets/diffview.nvim'

    use 'aklt/plantuml-syntax'

    use "LudoPinelli/comment-box.nvim"

    use {
      'google/executor.nvim',
      requires = "MunifTanjim/nui.nvim"
    }

    use 'uga-rosa/ccc.nvim'

    use 'uga-rosa/translate.nvim'

    use 'voldikss/vim-translator'

    use { 'j-hui/fidget.nvim', tag = 'legacy' }

    use "lukas-reineke/indent-blankline.nvim"

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
