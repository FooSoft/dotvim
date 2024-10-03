vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.gohtml',
    command = 'set filetype=html'
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = {'*.man', '*.kbom'},
    command = 'set filetype=xml'
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.w',
    command = 'set filetype=cpp'
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = {'sources', 'sources.inc', 'dirs'},
    command = 'set filetype=make'
})

vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold'}, {
    pattern = '*',
    command = 'checktime'
})

vim.api.nvim_create_autocmd({'BufEnter'}, {
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove({'c', 'r', 'o'})
    end
})
