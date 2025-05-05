if vim.fn.has('win32') == 1 then
    vim.opt.fileformat = 'dos'
    vim.diagnostic.enable(false)
end
