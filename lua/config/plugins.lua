local util = require('config.util')

-- argonaut.nvim
require('argonaut').setup({
    brace_pad = { ['{'] = true },
    by_filetype = {
        c = {
            brace_last_wrap = false
        },
        cpp = {
            brace_last_wrap = false
        }
    }
})

util.keymap({ 'x', 'o' }, 'ia', ':<C-u>ArgonautObject inner<cr>')
util.keymap({ 'x', 'o' }, 'aa', ':<C-u>ArgonautObject outer<cr>')
util.keymap({ 'x', 'o', 'n' }, '<leader>n', ':<C-u>ArgonautObject next<cr>')
util.keymap({ 'x', 'o', 'n' }, '<leader>p', ':<C-u>ArgonautObject previous<cr>')
util.keymap('n', '<leader>a', ':<C-u>ArgonautToggle<cr>')
util.keymap('n', '<leader>o', ':<C-u>ArgonautReflow<cr>')

-- comment.nvim
require('Comment').setup()

-- copilotchat.nvim
require('CopilotChat').setup({
    highlight_headers = false,
    insert_at_end = true,
    mappings = {
        jump_to_diff = { insert = '', normal = '' }, ---@diagnostic disable-line
        reset = { insert = '', normal = '' }, ---@diagnostic disable-line
    },
    resources = {
        'buffer',
        'selection'
    },
    separator = '---',
    show_folds = false,
    show_help = false,
    window = {
        layout = 'vertical',
        width = 0.40
    },
})

util.keymap({ 'n', 'v' }, '<leader>p', vim.cmd.CopilotChatToggle)

-- f5.nvim
require('f5').setup({
    enabled = false,
    reload_files = true,
    reload_modules = true,
})

-- fzf-lua
if util.has_executable('fzf') then
    vim.cmd.packadd('fzf-lua')

    local fzf_lua = require('fzf-lua')
    fzf_lua.register_ui_select()
    fzf_lua.setup({
        fzf_colors = true,
        winopts = {
            preview = {
                winopts = { cursorline = false } ---@diagnostic disable-line
            }
        }
    })

    local find_git_relative = function()
        fzf_lua.git_files({
            actions = {
                ['ctrl-r'] = function(selected, opts)
                    local source_dir = util.buffer_dir()

                    local target_path = fzf_lua.path.entry_to_file(selected[1]).path
                    if not util.is_abspath(target_path) then
                        target_path = vim.fs.joinpath(opts.cwd, target_path)
                    end

                    local relpath = util.relpath(source_dir, target_path)
                    vim.api.nvim_feedkeys('i' .. relpath, 'n', false)
                end
            },
        })
    end

    local grep_opts = {}
    if util.is_windows() then
        grep_opts.cmd = 'git grep --line-number --column --color=always'
    end

    util.keymap('n', '<leader>fb', fzf_lua.buffers)
    util.keymap('n', '<leader>fg', function() fzf_lua.git_files() end)
    util.keymap('n', '<leader>fh', fzf_lua.oldfiles)
    util.keymap('n', '<leader>fl', fzf_lua.lines)
    util.keymap('n', '<leader>fp', function() fzf_lua.grep(grep_opts) end)
    util.keymap('n', '<leader>fs', function() fzf_lua.live_grep(grep_opts) end)

    util.keymap('i', '<c-f>', find_git_relative)
end

-- gitsigns.nvim
require('gitsigns').setup({
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local filetype = vim.bo[bufnr].filetype
        if filetype == 'dirvish' or filetype == 'netrw' then
            return false
        end

        util.keymap('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next') ---@diagnostic disable-line
                end
            end,
            { buffer = bufnr }
        )

        util.keymap('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev') ---@diagnostic disable-line
                end
            end,
            { buffer = bufnr }
        )

        util.keymap('n', '<leader>hs', gitsigns.stage_hunk)
        util.keymap('n', '<leader>hr', gitsigns.reset_hunk)
        util.keymap('n', '<leader>hS', gitsigns.stage_buffer)
        util.keymap('n', '<leader>hR', gitsigns.reset_buffer)
        util.keymap('n', '<leader>hp', gitsigns.preview_hunk)
    end
})

-- guid.nvim
require('guid').setup({
    comma_space = true,
    styles = { h = '0x????????,0x????,0x????,0x??,0x??,0x??,0x??,0x??,0x??,0x??,0x??' },
})
util.keymap({ 'x', 'o' }, 'ag', ':<c-u>GuidObject<cr>')

-- lsp_signature.nvim
require('lsp_signature').setup({ hint_enable = false })

-- revolver.nvim
require('revolver').setup({ '.c', '.cpp', '.h', '.hpp', '.inl' })
util.keymap('n', 'gfs', vim.cmd.Revolve)

-- toggleterm.nvim
require('toggleterm').setup({
    open_mapping = [[<c-\>]]
})

-- suda.vim
if util.is_linux() then
    vim.cmd.packadd('suda.vim')
end

-- vim-better-whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { link = 'Search' })

-- vim-dirvish
vim.g.dirvish_mode = ':sort ,^.*[\\/],'

-- vim-easy-align
vim.g.easy_align_ignore_groups = {}
util.keymap('n', 'ga', '<plug>(EasyAlign)')
util.keymap('v', '<cr>', '<plug>(EasyAlign)')

-- vim-go
if util.has_executable('go') then
    vim.cmd.packadd('vim-go')
    vim.g.go_imports_autosave = 1
    vim.g.go_diagnostics_enabled = 0
end

-- vim-quickhl
util.keymap('n', '<leader>K', '<Plug>(quickhl-manual-reset)')
util.keymap('n', '<leader>k', '<Plug>(quickhl-manual-this-whole-word)')
util.keymap('x', '<leader>K', '<Plug>(quickhl-manual-reset)')
util.keymap('x', '<leader>k', '<Plug>(quickhl-manual-this-whole-word)')
