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

if vim.fn.filereadable('~/.local/share/cspell/vim.txt.gz') ~= 1 then
  local vim_dictionary_url = 'https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz'
  io.popen('curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs ' .. vim_dictionary_url)
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

require('lazy').setup({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    'simrat39/rust-tools.nvim',
    {
      'nvimdev/lspsaga.nvim',
      config = function()
        require('lazy/lspsaga').setup()
      end,
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
      }
    },
    {
      "jay-babu/mason-null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "williamboman/mason.nvim",
        'nvimtools/none-ls.nvim',
      },
    },
    'RRethy/nvim-treesitter-endwise',
    'SirVer/ultisnips',
    'honza/vim-snippets',
    {
      'L3MON4D3/LuaSnip',
      version = "V2.*",
      build = 'nix-shell -p luajit --run "make install_jsregexp"',
    },
    "rafamadriz/friendly-snippets",
    'onsails/lspkind.nvim',
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
        'davidsierradz/cmp-conventionalcommits',
        'saadparwaiz1/cmp_luasnip',
        'f3fora/cmp-spell',
      }
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter"
    },
    'mhartington/oceanic-next',
    'liuchengxu/vista.vim',
    {
      'nvim-treesitter/nvim-treesitter',
      build = ":TSUpdate"
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
      'windwp/nvim-ts-autotag',
      dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    'mvllow/modes.nvim',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'nvim-telescope/telescope-ghq.nvim',
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ghq.nvim'
      },
    },
    'nvim-tree/nvim-web-devicons',
    {
      'akinsho/bufferline.nvim',
      version = "*",
      dependencies = 'nvim-tree/nvim-web-devicons',
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    'mfussenegger/nvim-dap',
    {
      'junegunn/fzf',
      build = ":call fzf#install()"
    },
    'junegunn/fzf.vim',
    'junegunn/vim-easy-align',
    {
      'nvim-neo-tree/neo-tree.nvim',
      branch = "v3.x",
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        's1n7ax/nvim-window-picker',
      }
    },
    {
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      config = function()
        require 'window-picker'.setup()
      end,
    },
    'numToStr/Comment.nvim',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'kana/vim-submode',
    {
      'vim-jp/vimdoc-ja',
      ft = { 'help' },
      lazy = true,
    },
    -- git
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    -- snippet
    "smjonas/snippet-converter.nvim",
    {
      "folke/trouble.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
    },
    'sindrets/diffview.nvim',
    'aklt/plantuml-syntax',
    "LudoPinelli/comment-box.nvim",
    {
      'google/executor.nvim',
      dependencies = "MunifTanjim/nui.nvim"
    },
    'uga-rosa/ccc.nvim',
    'uga-rosa/translate.nvim',
    'voldikss/vim-translator',
    'j-hui/fidget.nvim',
    "lukas-reineke/indent-blankline.nvim",
    "HiPhish/rainbow-delimiters.nvim",
  },
  {
    ui = {
      border = "single"
    }
  }
)

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

vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')
