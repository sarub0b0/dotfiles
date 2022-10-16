vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

vim.keymap.set('', '<C-s>', '<Nop>', {})
vim.keymap.set('n', '<ESC><ESC>', '<Cmd>noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>m', '<Cmd>man<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-q>', '<Cmd>cclose<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set('n', 'Q', '<Nop>', {})

vim.keymap.set('', '<Space>h', '^', { noremap = true, silent = true })
vim.keymap.set('', '<Space>l', '$', { noremap = true, silent = true })
vim.keymap.set('n', '<Space>/', '*', { noremap = true, silent = true })

vim.keymap.set('n', 's', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'sh', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', 'sj', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', 'sk', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', 'sl', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', 'sH', '<C-w>H', { noremap = true, silent = true })
vim.keymap.set('n', 'sJ', '<C-w>J', { noremap = true, silent = true })
vim.keymap.set('n', 'sK', '<C-w>K', { noremap = true, silent = true })
vim.keymap.set('n', 'sL', '<C-w>L', { noremap = true, silent = true })

vim.keymap.set('n', 'st', '<C-w>t', { noremap = true, silent = true })
vim.keymap.set('n', 'sb', '<C-w>b', { noremap = true, silent = true })
vim.keymap.set('n', 'sp', '<C-w>p', { noremap = true, silent = true })

vim.keymap.set('n', 'sr', '<C-w>r', { noremap = true, silent = true })
vim.keymap.set('n', 'sR', '<C-w>R', { noremap = true, silent = true })
vim.keymap.set('n', 's=', '<C-w>=', { noremap = true, silent = true })
vim.keymap.set('n', 's0', '<C-w>=', { noremap = true, silent = true })
vim.keymap.set('n', 'sx', '<C-w>x', { noremap = true, silent = true })

vim.keymap.set('n', 'ss', '<C-w>s', { noremap = true, silent = true })
vim.keymap.set('n', 'sv', '<C-w>v', { noremap = true, silent = true })

-- vim.keymap.set('t', '<C-s>h', '<ESC><C-w>h', { silent = true })
-- vim.keymap.set('t', '<C-s>i', '<ESC><C-w>i', { silent = true })
-- vim.keymap.set('t', '<C-s>j', '<ESC><C-w>j', { silent = true })
-- vim.keymap.set('t', '<C-s>k', '<ESC><C-w>k', { silent = true })

vim.keymap.set('c', '<C-f>', '<Right>', { noremap = false, silent = false })
vim.keymap.set('c', '<C-b>', '<Left>', { noremap = false, silent = false })
vim.keymap.set('c', '<C-a>', '<Home>', { noremap = false, silent = false })
vim.keymap.set('c', '<C-e>', '<End>', { noremap = false, silent = false })

vim.keymap.set('n', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set('v', 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set('v', 'k', 'gk', { noremap = true, silent = true })

vim.keymap.set('i', '<C-f>', '<Right>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-b>', '<Left>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-n>', '<Cmd>cn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', '<Cmd>cp<CR>', { noremap = true, silent = true })

vim.keymap.set('n', ',v', '<Cmd>edit $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<Space>w', ':wa<CR>', { noremap = true, silent = true })
