local util = require('config.util')

if util.is_windows() then
    vim.bo.fileformat = 'dos'
    vim.diagnostic.enable(false)
end
