vim.opt_local.wrap = true
require('config.util').undo_ftplugin(function()
    vim.opt_local.wrap = vim.opt_global.wrap:get()
end)
