-- colors
vim.cmd.colorscheme('solarized8')

-- leader
vim.g.mapleader = ' '

-- options
vim.opt.autowrite = true
vim.opt.completeopt = 'menuone,noselect'
vim.opt.expandtab = true
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.foldenable = false
vim.opt.guicursor = 'n:blinkon0'
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.modeline = false
vim.opt.modelines = 0
vim.opt.number = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.writebackup = false

-- common keymaps
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set('n', '<bs>', '<cmd>bd<cr>')
vim.keymap.set('n', '<c-c><c-c>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader><leader>', '<cmd>b#<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- clipboard keymaps
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P')
vim.keymap.set({'n', 'v'}, '<leader>Y', '"+y$')
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d')
vim.keymap.set({'n', 'v'}, '<leader>d', '"+dd')
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'v'}, '<leader>yy', '"+yy')

-- split keymaps
vim.keymap.set('n', '<a-=>', '<c-w><c-=>')
vim.keymap.set('n', '<a-h>', '<c-w><')
vim.keymap.set('n', '<a-j>', '<c-w>+')
vim.keymap.set('n', '<a-k>', '<c-w>-')
vim.keymap.set('n', '<a-l>', '<c-w>>')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')
