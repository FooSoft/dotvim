vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
require('config.util').undo_ftplugin(function()
    vim.opt_local.shiftwidth = vim.opt_global.shiftwidth:get()
    vim.opt_local.tabstop = vim.opt_global.tabstop:get()
end)
