local util = require('config.util')

if util.is_windows() then
    vim.bo.expandtab = true
end
