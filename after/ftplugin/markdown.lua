vim.opt_local.spell = true
vim.opt_local.wrap = true

if vim.fn.has('win32') == 1 and vim.bo.modifiable then
    vim.bo.fileformat = 'dos'
end
