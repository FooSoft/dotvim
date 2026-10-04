local util = require('config.util')

if util.is_windows() then
    vim.bo.fileformat = 'dos'
    if vim.diagnostic.is_enabled({ bufnr = 0 }) then
        vim.diagnostic.enable(false, { bufnr = 0 })
        util.undo_ftplugin(function()
            vim.diagnostic.enable(true, { bufnr = 0 })
        end)
    end
end
