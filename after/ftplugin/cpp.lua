if vim.fn.has('win32') == 1 then
    vim.bo.fileformat = 'dos'
    vim.diagnostic.enable(false)
else
    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function(args) vim.lsp.buf.format() end
    })
end
