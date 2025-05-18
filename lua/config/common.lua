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
vim.opt.completeopt = 'menu,menuone,noinsert'
vim.opt.expandtab = true
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.foldenable = false
vim.opt.guicursor = 'n:blinkon0'
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.listchars = 'tab:» ,eol:↲,space:·'
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
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set('n', '<bs>', '<cmd>bp|bd#<cr>')
vim.keymap.set('n', '<c-c><c-c>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader><leader>', '<cmd>b#<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
vim.keymap.set('n', '<c-bs>', '<cmd>BuffDeleteAllButCurrent<cr>')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

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

-- terminal keymaps
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

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
