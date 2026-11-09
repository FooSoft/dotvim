local util = require('config.util')

-- General behavior
vim.g.mapleader = ' '
vim.g.editorconfig = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = ''
vim.opt.mousemodel = 'extend'
vim.opt.updatetime = 300

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Search and completion
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.spell = false
-- Show fuzzy matches without inserting a completion until it is accepted.
vim.opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert' }
vim.opt.matchpairs:append('<:>')

-- Display
vim.opt.conceallevel = 0
vim.opt.foldenable = false
vim.opt.linebreak = true
vim.opt.listchars = { tab = '» ', eol = '↲', space = '·' }
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.wrap = false

-- Refresh the global statusline so its clock advances while idle.
vim.opt.laststatus = 3
vim.opt.statusline = '%f %m%=%{strftime("%I:%M %p")} '
vim.fn.timer_start(1000, function()
    vim.cmd.redrawstatus()
end, { repeat_count = -1 })

-- File handling
vim.opt.autoread = true
vim.opt.fileformats = { 'unix', 'dos', 'mac' }
-- Ignore embedded modelines for security.
vim.opt.modeline = false
vim.opt.modelines = 0
vim.opt.swapfile = false
vim.opt.writebackup = true -- Keep a temporary backup until a write succeeds.
vim.opt.undofile = true

-- common keymaps
util.keymap('i', '<c-c>', '<esc>')
util.keymap('n', '<c-c><c-c>', '<cmd>nohlsearch<cr>')
util.keymap('n', '<leader>w', '<cmd>w<cr>')
util.keymap('n', '<leader>x', '<cmd>x<cr>')
util.keymap('n', 'Y', 'y$')
util.keymap('n', 'j', 'gj')
util.keymap('n', 'k', 'gk')

-- split keymaps
util.keymap({ 'n', 'v' }, '<a-=>', '<c-w><c-=>')
util.keymap({ 'n', 'v' }, '<a-h>', '<c-w><')
util.keymap({ 'n', 'v' }, '<a-j>', '<c-w>+')
util.keymap({ 'n', 'v' }, '<a-k>', '<c-w>-')
util.keymap({ 'n', 'v' }, '<a-l>', '<c-w>>')
util.keymap({ 'n', 'v' }, '<c-h>', '<c-w>h')
util.keymap({ 'n', 'v' }, '<c-j>', '<c-w>j')
util.keymap({ 'n', 'v' }, '<c-k>', '<c-w>k')
util.keymap({ 'n', 'v' }, '<c-l>', '<c-w>l')

-- terminal keymaps
util.keymap('t', '<esc>', '<c-\\><c-n>')
-- Waiting for a register in an expression mapping locks fzf's resize callbacks.
util.keymap('t', '<c-r>', function()
    local reg = vim.fn.getcharstr()
    if not reg:match('^[a-zA-Z0-9"*+%#:/%.=_%-]$') then
        return
    end
    local keys = vim.api.nvim_replace_termcodes('<c-\\><c-n>"' .. reg .. 'pi', true, false, true)
    vim.api.nvim_feedkeys(keys, 'ni', false)
end)

-- make and quickfix
util.keymap('n', '<leader>m', '<cmd>UpdateAndMake<cr>')
util.keymap('n', '<leader>q', '<cmd>ToggleQuickfix<cr>')
util.keymap('n', '<leader>e', '<cmd>cc<cr>')

-- autoreload files
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
    group = vim.api.nvim_create_augroup('checktime', { clear = true }),
    command = 'checktime',
    desc = 'Check for files changed outside of Neovim',
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

-- workaround for stale shada
vim.api.nvim_create_autocmd('VimLeavePre', {
    group = vim.api.nvim_create_augroup('delete_shada_temp', { clear = true }),
    callback = function()
        local status = 0
        for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('state') .. '/shada', '*.tmp.*', false, true)) do
            if vim.fn.getfsize(f) == 0 then
                status = status + vim.fn.delete(f)
            end
        end
        if status ~= 0 then
            vim.notify('Could not delete empty temporary ShaDa files.', vim.log.levels.ERROR)
        end
    end,
    desc = "Delete empty temp ShaDa files"
})
