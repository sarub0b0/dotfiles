if vim.g.vscode then
  return
end

if not vim.fn.has('termguicolors') == 1 then
  return
end

local function modify_highlight_transparent_bg_color(group_name)
  local gui = vim.api.nvim_get_hl_by_name(group_name, true)
  local cterm = vim.api.nvim_get_hl_by_name(group_name, false)
  local ctermfg = cterm.foreground
  local ctermbg = nil

  gui.background = nil
  cterm.foreground = nil
  cterm.background = nil

  local hl_value = vim.tbl_extend('error', gui, {
    ctermfg = ctermfg,
    ctermbg = ctermbg,
    cterm = cterm
  })

  vim.api.nvim_set_hl(0, group_name, hl_value)

end

vim.opt.termguicolors = true

vim.o.t_8f = "[38;2;%lu;%lu;%lum"
vim.o.t_8b = "[48;2;%lu;%lu;%lum"


local termcolor = 'OceanicNext'
local colorschemes = vim.fn.getcompletion(termcolor, 'color')

if vim.fn.index(colorschemes, termcolor) >= 0 then
  vim.g.oceanic_next_terminal_italic = 1
  vim.g.oceanic_next_terminal_bold = 1

  vim.cmd.colorscheme(termcolor)

  if vim.fn.has('nvim') == 1 then
    local group_names = { 'Normal', 'NormalFloat', 'NonText', 'LineNr', 'Folded', 'EndOfBuffer', 'SignColumn' }

    for _, name in pairs(group_names) do
      modify_highlight_transparent_bg_color(name)
    end

  end

  -- 31: let s:base02 = ['#4f5b66', '240']
  vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#4f5b66', bg = 'NONE', ctermfg = 240, ctermbg = 'NONE' })

  -- terminalの色を使えるようにbg=NONEに設定する。
  -- あと、clearedになると背景色がついちゃうので適当にfgを設定しておく
  -- vim.api.nvim_set_hl(0, 'Floaterm', { fg = vim.g.terminal_color_foreground, bg = 'NONE' })
  -- vim.api.nvim_set_hl(0, 'FloatermBorder', { fg = vim.g.terminal_color_foreground, bg = 'NONE' })

end

-- vim.api.nvim_create_augroup('TransparentBG', {})
-- for _, name in pairs(group_names) do
--   vim.api.nvim_create_autocmd({ 'Colorscheme' }, {
--     pattern = '*',
--     callback = function()
--       local gui = vim.api.nvim_get_hl_by_name(name, true)
--       local cterm = vim.api.nvim_get_hl_by_name(name, false)
--       local ctermfg = cterm.foreground
--       local ctermbg = nil
--
--       gui.background = nil
--       cterm.foreground = nil
--       cterm.background = nil
--
--       local hl_value = vim.tbl_extend('error', gui, {
--         ctermfg = ctermfg,
--         ctermbg = ctermbg,
--         cterm = cterm
--       })
--
--       vim.api.nvim_set_hl(0, name, hl_value)
--     end,
--     group = 'TransparentBG'
--   })
-- end
