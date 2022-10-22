vim.opt.expandtab = false

vim.keymap.set('n', '<leader>b', '<cmd>plug>(go-build)')
vim.keymap.set('n', '<leader>c', '<cmd>plug>(go-coverage)')
vim.keymap.set('n', '<leader>r', '<cmd>plug>(go-run)')
vim.keymap.set('n', '<leader>t', '<cmd>plug>(go-test)')

vim.b.argwrap_tail_comma = 1
