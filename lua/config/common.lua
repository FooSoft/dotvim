local util = require('config.util')

-- set the <space> key as the leader key for custom mappings
vim.g.mapleader = ' '

-- disable editorconfig integration
vim.g.editorconfig = false

-- automatically reread files changed outside of neovim
vim.opt.autoread = true

-- use system clipboard for all operations
vim.opt.clipboard = 'unnamedplus'

-- completion options: fuzzy matching, show menu, select even with one match, don't insert by default
vim.opt.completeopt = { 'fuzzy', 'menu', 'menuone', 'noinsert' }

-- disable conceal (no hidden text in markdown, etc)
vim.opt.conceallevel = 0

-- use spaces instead of tabs
vim.opt.expandtab = true

-- recognize these file formats
vim.opt.fileformats = { 'unix', 'dos', 'mac' }

-- disable code folding by default
vim.opt.foldenable = false

-- ignore case in search patterns
vim.opt.ignorecase = true

-- wrap long lines at convenient points
vim.opt.linebreak = true

-- display characters for tabs, end-of-line, and spaces
vim.opt.listchars = { tab = '» ', eol = '↲', space = '·' }

-- add angle brackets as matchpairs for % motion
vim.opt.matchpairs:append('<:>')

-- disable modeline for security
vim.opt.modeline = false
vim.opt.modelines = 0

-- enable mouse in normal and visual modes
vim.opt.mouse = 'nv'

-- mouse model: extend selection with mouse
vim.opt.mousemodel = 'extend'

-- show absolute line numbers
vim.opt.number = true

-- round indent to nearest multiple of shiftwidth
vim.opt.shiftround = true

-- number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 4

-- override 'ignorecase' if search pattern contains uppercase
vim.opt.smartcase = true

-- disable spell checking by default
vim.opt.spell = false

-- don't use swap files
vim.opt.swapfile = false

-- number of spaces that a <tab> in the file counts for
vim.opt.tabstop = 4

-- enable true color support
vim.opt.termguicolors = true

-- faster update time for cursorhold events
vim.opt.updatetime = 300

-- don't wrap lines by default
vim.opt.wrap = false

-- don't keep a backup while overwriting a file
vim.opt.writebackup = false

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
util.keymap('t', '<c-r>', function()
    local reg = vim.fn.nr2char(vim.fn.getchar())
    return '<c-\\><c-n>"' .. reg .. 'pi'
end, { expr = true })

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
        for _, f in ipairs(vim.fn.globpath(vim.fn.stdpath('data') .. '/shada', '*tmp*', false, true)) do
            if vim.tbl_isempty(vim.fn.readfile(f)) then
                status = status + vim.fn.delete(f)
            end
        end
        if status ~= 0 then
            vim.notify('Could not delete empty temporary ShaDa files.', vim.log.levels.ERROR)
        end
    end,
    desc = "Delete empty temp ShaDa files"
})
