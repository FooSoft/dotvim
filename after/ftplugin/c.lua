local util = require('config.util')

local function toggle_param_comment()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    for first, name, last in line:gmatch('()([%a_][%w_]*)()') do
        if col >= first - 1 and col < last - 1 then
            local open = line:sub(1, first - 1):find('/%*%s*$')
            local _, close = line:sub(last):find('^%s*%*/')
            local start_col, end_col = first - 1, last - 1
            local replacement, new_col = '/* ' .. name .. ' */', col + 3
            if open and close then
                start_col, end_col = open - 1, last + close - 1
                replacement, new_col = name, col - (first - open)
            end
            vim.api.nvim_buf_set_text(0, row - 1, start_col, row - 1, end_col, { replacement })
            vim.api.nvim_win_set_cursor(0, { row, new_col })
            return
        end
    end
end

vim.api.nvim_buf_create_user_command(0, 'ToggleParamComment', toggle_param_comment, {
    desc = 'Toggle an inline block comment around the parameter name under the cursor',
})

util.keymap('n', 'gcp', '<cmd>ToggleParamComment<cr>', {
    buffer = 0,
    desc = 'Toggle parameter-name comment',
})

util.undo_ftplugin('silent! execute "nunmap <buffer> gcp" | silent! delcommand -buffer ToggleParamComment')
