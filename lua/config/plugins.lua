local util = require('config.util')

-- argonaut.nvim
require('argonaut').setup({
    brace_pad = { ['{'] = true },
    by_filetype = {
        c = { brace_last_wrap = false },
        cpp = { brace_last_wrap = false }
    }
})

util.keymap({ 'x', 'o' }, 'ia', ':<C-u>ArgonautObject inner<cr>')
util.keymap({ 'x', 'o' }, 'aa', ':<C-u>ArgonautObject outer<cr>')
util.keymap({ 'x', 'o', 'n' }, '<leader>n', ':<C-u>ArgonautObject next<cr>')
util.keymap({ 'x', 'o', 'n' }, '<leader>p', ':<C-u>ArgonautObject previous<cr>')
util.keymap('n', '<leader>a', ':<C-u>ArgonautToggle<cr>')
util.keymap('n', '<leader>o', ':<C-u>ArgonautReflow<cr>')

-- catppuccin.nvim
require('catppuccin').setup({
    flavour = 'macchiato',
    show_end_of_buffer = true,
    styles = { conditionals = {}, miscs = {} },
    custom_highlights = {
        ExtraWhitespace = { link = 'Search' },
    },
})

vim.cmd.colorscheme('catppuccin')

-- f5.nvim
require('f5').setup({
    enabled = false,
    reload_files = true,
    reload_modules = true,
})

-- fzf-lua
if util.has_executable('fzf') then
    local fzf_lua = require('fzf-lua')
    fzf_lua.register_ui_select()
    fzf_lua.setup({
        fzf_colors = true,
        winopts = {
            backdrop = 100,
            preview = { winopts = { cursorline = false } } ---@diagnostic disable-line
        }
    })

    local find_git_relative = function()
        local source_buf = vim.api.nvim_get_current_buf()
        local source_dir = util.buffer_dir()
        local source_pos = vim.api.nvim_win_get_cursor(0)
        fzf_lua.git_files({
            actions = {
                ['ctrl-r'] = function(selected, opts)
                    if not selected[1] or vim.api.nvim_get_current_buf() ~= source_buf then
                        return
                    end
                    local target_path = fzf_lua.path.entry_to_file(selected[1], opts).path
                    local relpath = util.relpath(source_dir, target_path)
                    local row, col = source_pos[1] - 1, source_pos[2]
                    vim.api.nvim_buf_set_text(source_buf, row, col, row, col, { relpath })
                    col = col + #relpath
                    vim.api.nvim_win_set_cursor(0, { row + 1, col })
                    vim.cmd.startinsert({ bang = col == #vim.api.nvim_get_current_line() })
                end
            },
        })
    end

    local grep_opts = {}
    if util.is_windows() then
        grep_opts.cmd = 'git grep --line-number --column --color=always'
    end

    util.keymap('n', '<leader>fb', fzf_lua.buffers)
    util.keymap('n', '<leader>fd', function() fzf_lua.git_diff() end)
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

        local opts = { buffer = bufnr }
        util.keymap('n', '<leader>hs', gitsigns.stage_hunk, opts)
        util.keymap('n', '<leader>hr', gitsigns.reset_hunk, opts)
        util.keymap('n', '<leader>hS', gitsigns.stage_buffer, opts)
        util.keymap('n', '<leader>hR', gitsigns.reset_buffer, opts)
        util.keymap('n', '<leader>hp', gitsigns.preview_hunk, opts)
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
util.keymap('n', 'gfs', vim.cmd.Revolve)

-- toggleterm.nvim: bind each hotkey to a fixed terminal id so it always toggles
-- exactly that terminal. The default "smart" open_mapping restores the last-used
-- terminal view, which let the <c-/> work terminal hijack the <c-\> Copilot key.
require('toggleterm').setup({})

-- LLM lives on terminal id 1 (start it / toggle it), scratch work terminal on id 2.
-- <c-_> is the byte many terminals send for <c-/>; map both for portability.
util.keymap({ 'n', 't' }, '<c-\\>', util.toggle_copilot)
for _, lhs in ipairs({ '<c-/>', '<c-_>' }) do
    util.keymap({ 'n', 't' }, lhs, '<cmd>2ToggleTerm direction=float<cr>')
end

-- vim-dirvish
vim.g.dirvish_mode = ':sort ,^.*[\\/],'

-- vim-easy-align
vim.g.easy_align_ignore_groups = {}
util.keymap('n', 'ga', '<plug>(EasyAlign)')
util.keymap('v', '<cr>', '<plug>(EasyAlign)')

-- vim-quickhl
util.keymap({ 'n', 'x' }, '<leader>K', '<Plug>(quickhl-manual-reset)')
util.keymap({ 'n', 'x' }, '<leader>k', '<Plug>(quickhl-manual-this-whole-word)')
