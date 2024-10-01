if vim.fn.has('win32') == 1 then
    if vim.g.neovide then
        vim.g.neovide_cursor_trail_size = 0.05
        vim.o.guifont = 'Cascadia Mono:h14'
    elseif vim.fn.has(':GuiTabline') then
        vim.cmd.GuiTabline(0)
        vim.cmd.GuiPopupmenu(0)
        vim.cmd.GuiFont({
            args = {'Cascadia Mono:h10'},
            bang = true
        })
    end
end
