-- argonaut.nvim
vim.keymap.set('n', '<leader>e', function()
    vim.cmd.ArgonautReload()
    vim.cmd.ArgonautReflow()
end)

-- comment.nvim
require('Comment').setup()

-- fzf-lua
if vim.fn.executable('fzf') == 1 then
    local fzf_lua = require('fzf-lua')
    fzf_lua.setup({
        winopts = {
            preview = {
                winopts = {
                    cursorline = false,
                },
            },
        },
    })

    vim.keymap.set('n', '<leader>fb', fzf_lua.buffers)
    vim.keymap.set('n', '<leader>fg', fzf_lua.git_files)
    vim.keymap.set('n', '<leader>fh', fzf_lua.oldfiles)
    vim.keymap.set('n', '<leader>fl', fzf_lua.lines)
    vim.keymap.set('n', '<leader>fp', fzf_lua.grep)
    vim.keymap.set('n', '<leader>fs', fzf_lua.live_grep_native)
end

-- guid.nvim
require('guid').setup({
    comma_space = true
})

-- lualine.nvim
require('lualine').setup {
    options = {
        always_divide_middle = true,
        component_separators = {left = '', right = ''},
        disabled_filetypes = {statusline = {}, winbar = {}},
        globalstatus = false,
        icons_enabled = false,
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

-- revolver.nvim
require('revolver').setup({'.c', '.cpp', '.h', '.hpp', '.inl'})
vim.keymap.set('n', 'gfs', vim.cmd.Revolver)

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
vim.g.go_imports_autosave = 1
vim.g.go_metalinter_enabled = {}
vim.g.go_null_module_warning = 0
vim.g.go_version_warning = 0

-- vim-polyglot
vim.g.rustfmt_autosave = 1

-- vim-quickhl
vim.keymap.set('n', '<leader>K', '<Plug>(quickhl-manual-reset)')
vim.keymap.set('n', '<leader>k', '<Plug>(quickhl-manual-this)')
vim.keymap.set('x', '<leader>K', '<Plug>(quickhl-manual-reset)')
vim.keymap.set('x', '<leader>k', '<Plug>(quickhl-manual-this)')
