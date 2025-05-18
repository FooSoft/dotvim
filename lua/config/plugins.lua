-- argonaut.nvim
require('argonaut').setup({
    by_filetype = {
        c = {brace_last_wrap = false},
        cpp = {brace_last_wrap = false},
    },
})

vim.keymap.set({'x', 'o'}, 'ia', ':<C-u>ArgonautObject inner<cr>', {noremap = true, silent = true})
vim.keymap.set({'x', 'o'}, 'aa', ':<C-u>ArgonautObject outer<cr>', {noremap = true, silent = true})
vim.keymap.set({'x', 'o', 'n'}, '<leader>n', ':<C-u>ArgonautObject next<cr>', {noremap = true, silent = true})
vim.keymap.set({'x', 'o', 'n'}, '<leader>p', ':<C-u>ArgonautObject previous<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>a', ':<C-u>ArgonautToggle<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>o', ':<C-u>ArgonautReflow<cr>', {noremap = true, silent = true})

-- bmessages.nvim
require('bmessages').setup({
    split_direction = 'botright'
})

vim.keymap.set(
    'n',
    '<leader>bm',
    ':Bmessages<CR>',
    {noremap = true, silent = true}
)

-- comment.nvim
require('Comment').setup()

-- f5.nvim
require('f5').setup({
    reload_files = true,
    reload_modules = true,
})

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

    local grep_opts = nil
    if vim.fn.has('win32') == 1 then
        grep_opts = {
            cmd = 'git grep --line-number --column --color=always'
        }
    end

    local live_grep = function()
        fzf_lua.live_grep(grep_opts)
    end

    local grep = function()
        fzf_lua.grep(grep_opts)
    end

    vim.keymap.set('n', '<leader>fb', fzf_lua.buffers)
    vim.keymap.set('n', '<leader>fg', fzf_lua.git_files)
    vim.keymap.set('n', '<leader>fh', fzf_lua.oldfiles)
    vim.keymap.set('n', '<leader>fl', fzf_lua.lines)
    vim.keymap.set('n', '<leader>fp', grep)
    vim.keymap.set('n', '<leader>fs', live_grep)
end

-- gitsigns.nvim
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
})

-- guid.nvim
require('guid').setup({
    comma_space = true
})

vim.keymap.set({'x', 'o'}, 'ag', ':<c-u>GuidObject<cr>', {noremap = true, silent = true})

-- lsp_signature.nvim
require('lsp_signature').setup({
    hint_enable = false,
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
        refresh = {statusline = 100, tabline = 100, winbar = 100},
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
vim.keymap.set('n', 'gfs', vim.cmd.Revolve)

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

-- vim-quickhl
vim.keymap.set('n', '<leader>K', '<Plug>(quickhl-manual-reset)')
vim.keymap.set('n', '<leader>k', '<Plug>(quickhl-manual-this-whole-word)')
vim.keymap.set('x', '<leader>K', '<Plug>(quickhl-manual-reset)')
vim.keymap.set('x', '<leader>k', '<Plug>(quickhl-manual-this-whole-word)')
