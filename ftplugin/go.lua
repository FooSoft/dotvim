vim.opt.expandtab = false

vim.keymap.set('n', '<leader><f5>', '<cmd>GoDebugStart<cr>')
vim.keymap.set('n', '<leader><f9>', '<cmd>GoDebugBreakpoint<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>plug>(go-build)')
vim.keymap.set('n', '<leader>c', '<cmd>plug>(go-coverage)')
vim.keymap.set('n', '<leader>r', '<cmd>plug>(go-run)')
vim.keymap.set('n', '<leader>t', '<cmd>plug>(go-test)')
vim.keymap.set('n', '<s-f11>', '<cmd>GoDebugStepOut<cr>')
vim.keymap.set('n', '<s-f5>', '<cmd>GoDebugStop<cr>')

vim.b.argwrap_tail_comma = 1
