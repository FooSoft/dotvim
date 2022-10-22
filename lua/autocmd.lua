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
