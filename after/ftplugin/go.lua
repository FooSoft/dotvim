vim.opt.expandtab = false

vim.keymap.set('n', '<leader>b', vim.cmd.GoBuild)
vim.keymap.set('n', '<leader>c', vim.cmd.GoCoverage)
vim.keymap.set('n', '<leader>i', vim.cmd.GoInstall)
vim.keymap.set('n', '<leader>r', vim.cmd.GoRun)
vim.keymap.set('n', '<leader>t', vim.cmd.GoTest)
