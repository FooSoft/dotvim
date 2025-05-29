local util = require('config.util')

vim.opt_local.spell = true
vim.opt_local.wrap = true

if util.is_windows() and vim.bo.modifiable then
    vim.bo.fileformat = 'dos'
end
