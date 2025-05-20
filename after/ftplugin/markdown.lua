vim.wo.spell = true
vim.wo.wrap = true

if vim.fn.has('win32') == 1 and vim.bo.modifiable then
    vim.bo.fileformat = 'dos'
end
