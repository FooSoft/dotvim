vim.cmd.GuiTabline(0)
vim.cmd.GuiPopupmenu(0)

local font
if vim.fn.has('unix') == 1 then
    font = 'Terminus:h12'
elseif vim.fn.has('win32') == 1 then
    font = 'Lucida Console:h8'
end

if font then
    vim.cmd.Guifont({args = {font}, bang = true})
end
