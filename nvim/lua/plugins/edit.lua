return {
  'sindrets/diffview.nvim',
  'mfussenegger/nvim-dap',
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
    }
  },
  {
    'junegunn/fzf',
    build = ":call fzf#install()"
  },
  'junegunn/fzf.vim',
  {
    'kana/vim-submode',
    config = function()
      vim.fn['submode#enter_with']('bufmove', 'n', '', 's>', '<C-w>>')
      vim.fn['submode#enter_with']('bufmove', 'n', '', 's<', '<C-w><')
      vim.fn['submode#enter_with']('bufmove', 'n', '', 's+', '<C-w>+')
      vim.fn['submode#enter_with']('bufmove', 'n', '', 's-', '<C-w>-')
      vim.fn['submode#map']('bufmove', 'n', '', '>', '<C-w>>')
      vim.fn['submode#map']('bufmove', 'n', '', '<', '<C-w><')
      vim.fn['submode#map']('bufmove', 'n', '', '+', '<C-w>+')
      vim.fn['submode#map']('bufmove', 'n', '', '-', '<C-w>-')

      vim.fn['submode#enter_with']('up/down', 'n', '', 'gj', 'gj')
      vim.fn['submode#enter_with']('up/down', 'n', '', 'gk', 'gk')
      vim.fn['submode#map']('up/down', 'n', '', 'j', 'gj')
      vim.fn['submode#map']('up/down', 'n', '', 'k', 'gk')
    end
  },
  'tpope/vim-surround',
  'tpope/vim-repeat',
  "LudoPinelli/comment-box.nvim",
  {
    'numToStr/Comment.nvim',
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    opts = function()
      return {
        sticky = false,
        mappings = {
          basic = true,
          extra = false,
          extended = false,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    keys = {
      { '<Space>m' },
      { '<Space>s' },
      { '<Space>j' },
    },
    opts = {}
  }
}
