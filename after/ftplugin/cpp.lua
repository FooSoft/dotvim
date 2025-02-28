vim.diagnostic.enable(false)

if vim.fn.has('win32') == 1 then
    vim.opt.fileformat = 'dos'
end
