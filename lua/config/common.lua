local util = require('config.util')

-- colors
vim.cmd.colorscheme('nightfox')

-- leader
vim.g.mapleader = ' '

-- misc settings
vim.g.editorconfig = false
vim.g.c_no_if0 = 1

-- options
vim.opt.autoread = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}
vim.opt.expandtab = true
vim.opt.fileformats = {'unix', 'dos', 'mac'}
vim.opt.foldenable = false
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.listchars = {tab = '» ', eol = '↲', space = '·'}
vim.opt.modeline = false
vim.opt.modelines = 0
vim.opt.mouse = 'nv'
vim.opt.mousemodel = 'extend'
vim.opt.number = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.shortmess:append('c')
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.spell = false
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.writebackup = false

-- common keymaps
util.keymap('i', '<c-c>', '<esc>')
util.keymap('n', '<bs>', '<cmd>bp|bd#<cr>')
util.keymap('n', '<c-c><c-c>', '<cmd>nohlsearch<cr>')
util.keymap('n', '<leader><leader>', '<cmd>b#<cr>')
util.keymap('n', '<leader>w', '<cmd>w<cr>')
util.keymap('n', '<leader>x', '<cmd>x<cr>')
util.keymap('n', '<c-bs>', '<cmd>BuffDeleteAllButCurrent<cr>')
util.keymap('n', 'Y', 'y$')
util.keymap('n', 'j', 'gj')
util.keymap('n', 'k', 'gk')

-- split keymaps
util.keymap('n', '<a-=>', '<c-w><c-=>')
util.keymap('n', '<a-h>', '<c-w><')
util.keymap('n', '<a-j>', '<c-w>+')
util.keymap('n', '<a-k>', '<c-w>-')
util.keymap('n', '<a-l>', '<c-w>>')
util.keymap('n', '<c-h>', '<c-w>h')
util.keymap('n', '<c-j>', '<c-w>j')
util.keymap('n', '<c-k>', '<c-w>k')
util.keymap('n', '<c-l>', '<c-w>l')

-- terminal keymaps
util.keymap('t', '<esc>', '<c-\\><c-n>')

-- make
util.keymap('n', '<leader>m', util.make)

-- autoreload files
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold'}, {
    pattern = '*',
    command = 'checktime'
})

-- filetypes
vim.filetype.add({
    extension = {
        gohtml = 'html',
        kbom = 'xml',
        man = 'xml',
        w = 'cpp',
    },
    filename = {
        ['dirs'] = 'make',
        ['sources'] = 'make',
        ['sources.inc'] = 'make',
    },
})
