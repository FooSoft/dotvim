vim.opt_local.spell = true
require('config.util').undo_ftplugin(function()
    vim.opt_local.spell = vim.opt_global.spell:get()
end)
