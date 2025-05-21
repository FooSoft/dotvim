local util = require('config.util')

vim.bo.expandtab = false

util.keymap('n', '<leader>b', vim.cmd.GoBuild)
util.keymap('n', '<leader>c', vim.cmd.GoCoverage)
util.keymap('n', '<leader>i', vim.cmd.GoInstall)
util.keymap('n', '<leader>r', vim.cmd.GoRun)
util.keymap('n', '<leader>t', vim.cmd.GoTest)
