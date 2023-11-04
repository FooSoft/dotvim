vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        pattern = '*.gohtml',
        command = 'set filetype=html'
    }
)

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        pattern = '*.man',
        command = 'set filetype=xml'
    }
)

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
        pattern = '*.w',
        command = 'set filetype=cpp'
    }
)
