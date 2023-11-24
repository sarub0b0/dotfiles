return {
  {
    'liuchengxu/vista.vim',
    init = function()
      vim.g.vista_echo_cursor = 0
      vim.g.vista_sidebar_width = 40
      vim.g['vista#renderer#enable_icon'] = 1
      vim.g.vista_default_executive = 'nvim_lsp'

      vim.api.nvim_create_autocmd(
        {
          "FileType"
        },
        {
          pattern = { "vista", "vista_kind" },
          command = 'nnoremap <buffer><silent> / :<c-u>call vista#finder#fzf#Run()<CR>',
          group = vim.g.augroup_names.my_auto_cmds
        }
      )
    end,
    keys = {
      { '<Leader>v', ':<C-u>Vista!!<CR>', silent = true },
    }
  }
}
