vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = 0,
    callback = function() vim.lsp.buf.format() end
})
