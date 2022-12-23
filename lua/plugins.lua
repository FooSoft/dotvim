-- comment.nvim
require('Comment').setup()

-- fzf.vim
if vim.fn.executable('fzf') then
    vim.g['$FZF_DEFAULT_COMMAND'] = 'ag --hidden --ignore .git -f -g "" 2> /dev/null'

    vim.keymap.set('n', '<leader>fg', vim.cmd.GFiles)
    vim.keymap.set('n', '<leader>fh', vim.cmd.History)
    vim.keymap.set('n', '<leader>fb', vim.cmd.Buffers)
    vim.keymap.set('n', '<leader>fl', vim.cmd.Lines)
end

-- hflip.nvim
vim.keymap.set('n', 'gfs', vim.cmd.HFlip)

-- lualine.nvim
require('lualine').setup {
    options = {
        always_divide_middle = true,
        component_separators = {left = '', right = ''},
        disabled_filetypes = {statusline = {}, winbar = {}},
        globalstatus = false,
        icons_enabled = true,
        ignore_focus = {},
        refresh = {statusline = 1000, tabline = 1000, winbar = 1000},
        section_separators = {left = '', right = ''},
        theme = 'auto',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

-- vim-argwrap
vim.keymap.set('n', '<leader>a', vim.cmd.ArgWrap)

-- vim-better-whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', {link = 'Search'})

-- vim-dirvish
vim.g.dirvish_mode = ':sort ,^.*[\\/],'

-- vim-easy-align
vim.g.easy_align_ignore_groups = {}
vim.keymap.set('n', 'ga', '<plug>(EasyAlign)')
vim.keymap.set('v', '<cr>', '<plug>(EasyAlign)')

-- vim-go
vim.g.go_diagnostics_enabled = 0
vim.g.go_imports_autosave = 0
vim.g.go_metalinter_enabled = {}
vim.g.go_null_module_warning = 0
vim.g.go_version_warning = 0

-- vim-interestingwords
vim.g.interestingWordsGUIColors = {'#8ccbea', '#a4e57e', '#ffdb72', '#ff7272', '#ffb3ff', '#9999ff'}
vim.g.interestingWordsTermColors = {'154', '121', '211', '137', '214', '222'}

-- vim-polyglot
vim.g.rustfmt_autosave = 1
