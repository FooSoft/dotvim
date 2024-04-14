vim.cmd.GuiTabline(0)
vim.cmd.GuiPopupmenu(0)

if vim.fn.has('win32') == 1 then
    vim.cmd.Guifont({
        args = {'Cascadia Mono:h10'},
        bang = true
    })
end
