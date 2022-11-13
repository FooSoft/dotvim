vim.api.nvim_create_autocmd(
    'UIEnter', {
        callback = function()
            if vim.v.event.chan == 1 then
                require('ginit')
            end
        end,
        once = true,
    }
)

vim.api.nvim_create_autocmd(
    'BufRead,BufNewFile', {
        pattern = '*.gohtml',
        command = 'set filetype=html'
    }
)

vim.api.nvim_create_autocmd(
    'BufRead,BufNewFile', {
        pattern = '*.man',
        command = 'set filetype=xml'
    }
)

vim.api.nvim_create_autocmd(
    'BufRead,BufNewFile', {
        pattern = '*.w',
        command = 'set filetype=cpp'
    }
)
