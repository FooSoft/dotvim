local util = require('config.util')

vim.bo.expandtab = false

local opts = { buffer = 0 }
util.keymap('n', '<leader>b', vim.cmd.GoBuild, opts)
util.keymap('n', '<leader>c', vim.cmd.GoCoverage, opts)
util.keymap('n', '<leader>i', vim.cmd.GoInstall, opts)
util.keymap('n', '<leader>r', vim.cmd.GoRun, opts)
util.keymap('n', '<leader>t', vim.cmd.GoTest, opts)
