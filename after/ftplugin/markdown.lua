local util = require('config.util')

vim.opt_local.spell = true
vim.opt_local.wrap = true
util.undo_ftplugin('setlocal spell< wrap<')
