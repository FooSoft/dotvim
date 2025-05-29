local util = require('config.util')

if vim.g.neovide then
    vim.g.neovide_floating_blur_amount_x = 0.0
    vim.g.neovide_floating_blur_amount_y = 0.0
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animation_length = 0.0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.0

    if util.is_windows() then
        vim.o.guifont = 'Cascadia Mono:h14'
    elseif util.is_linux() then
        vim.o.guifont = 'Monospace:h12'
    end
else
    if vim.fn.has(':GuiPopupmenu') then
        vim.cmd.GuiPopupmenu(0)
    end

    if vim.fn.has(':GuiTabline') then
        vim.cmd.GuiTabline(0)
    end

    if vim.fn.has(':GuiFont') == 1 then
        if util.is_windows() then
            vim.cmd.GuiFont({
                args = { 'Cascadia Mono:h10' },
                bang = true
            })
        elseif util.is_linux() then
            vim.o.guifont = 'Monospace:h10'
        end
    end
end
