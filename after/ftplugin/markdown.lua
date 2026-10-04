local util = require('config.util')

vim.opt_local.spell = true
vim.opt_local.wrap = true
util.undo_ftplugin(function()
    vim.opt_local.spell = vim.opt_global.spell:get()
    vim.opt_local.wrap = vim.opt_global.wrap:get()
end)

if util.is_windows() and vim.bo.modifiable then
    vim.bo.fileformat = 'dos'
end
