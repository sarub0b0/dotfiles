local function has(feature)
  return vim.fn.has(feature) == 1
end

vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "iso2022-jp", "euc-jp", "sjis" }

vim.opt.shortmess:append({ I = true, S = true })

vim.opt.helplang = { "ja" }

vim.opt.formatoptions:append({ m = true, M = true })

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "-", nbsp = "%" }

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wildmode = { "list:longest", "full" }

vim.opt.completeopt = { "menu", "menuone" }

vim.opt.wildignore = { "*.o", "*.obj", "GTAGS", "GPATH", "GRTAGS", "core" }
vim.opt.grepprg = "grep -rnHI"

vim.opt.mouse = ""

vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.pumheight = 20

if has("persistent_undo") then
  vim.opt.undodir = vim.fn.expand("~/.cache/vimundo")
  vim.opt.undofile = true
end

vim.g.tlist_tex_settings = "latex;l:labels;c:chapter;s:sections;t:subsections;u:subsubsections"

vim.opt.iskeyword = { "@", "48-57", "_", "-", "192-255" }

vim.opt.fillchars:append({ diff = " " })

vim.opt.diffopt:append({ "indent-heuristic", "algorithm:histogram" })

vim.cmd([[
  set clipboard&
  set clipboard^=unnamedplus,unnamed
]])

vim.opt.pumblend = 10

vim.opt.termguicolors = true

vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
