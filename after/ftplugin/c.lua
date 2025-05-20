if vim.fn.has('win32') == 1 then
    vim.optlocal.fileformat = 'dos'
    vim.diagnostic.enable(false)
end
