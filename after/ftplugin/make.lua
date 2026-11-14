if vim.tbl_contains({ 'sources', 'sources.inc', 'dirs' }, vim.fn.expand('%:t')) then
    vim.bo.expandtab = true
    require('config.util').undo_ftplugin('setlocal expandtab<')
end
