-- fzf.vim
vim.keymap.set('n', '<leader>fg', vim.cmd.GFiles)
vim.keymap.set('n', '<leader>fh', vim.cmd.History)
vim.keymap.set('n', '<leader>fb', vim.cmd.Buffers)
vim.keymap.set('n', '<leader>fl', vim.cmd.Lines)

-- hflip.nvim
vim.keymap.set('n', 'gfs', vim.cmd.HFlip)

-- vim-airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline_symbols_ascii'] = 1

-- vim-argwrap
vim.keymap.set('n', '<leader>a', vim.cmd.ArgWrap)

-- vim-better-whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#6c71c4' })

-- vim-dirvish
vim.g.dirvish_mode = ':sort ,^.*[\\/],'

-- vim-easy-align
vim.g.easy_align_ignore_groups = {}
vim.keymap.set('n', 'ga', '<plug>(EasyAlign)')
vim.keymap.set('v', '<cr>', '<plug>(EasyAlign)')

-- vim-go
vim.g.go_diagnostics_enabled = 0
vim.g.go_imports_autosave = 0
vim.g.go_metalinter_enabled = {}
vim.g.go_null_module_warning = 0
vim.g.go_version_warning = 0

-- vim-interestingwords
vim.g.interestingWordsGUIColors = { '#8ccbea', '#a4e57e', '#ffdb72', '#ff7272', '#ffb3ff', '#9999ff' }
vim.g.interestingWordsTermColors = { '154', '121', '211', '137', '214', '222' }

-- vim-polyglot
vim.g.rustfmt_autosave = 1
