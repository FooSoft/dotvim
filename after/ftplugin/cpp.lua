local util = require('config.util')

if util.is_windows() then
    vim.bo.fileformat = 'dos'
    vim.diagnostic.enable(false, { bufnr = 0 })
end

vim.cmd('highlight! link @comment NONE')
