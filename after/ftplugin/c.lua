if vim.fn.has('win32') == 1 then
    vim.bo.fileformat = 'dos'
    vim.diagnostic.enable(false)
end
