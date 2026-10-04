local util = require('config.util')

vim.bo.expandtab = false
util.undo_ftplugin(function()
    vim.opt_local.expandtab = vim.opt_global.expandtab:get()
end)

if vim.fn.exists(':GoBuild') ~= 2 then
    return
end

local opts = { buffer = 0 }
util.keymap('n', '<leader>b', vim.cmd.GoBuild, opts)
util.keymap('n', '<leader>c', vim.cmd.GoCoverage, opts)
util.keymap('n', '<leader>i', vim.cmd.GoInstall, opts)
util.keymap('n', '<leader>r', vim.cmd.GoRun, opts)
util.keymap('n', '<leader>t', vim.cmd.GoTest, opts)

util.undo_ftplugin(function()
    for _, key in ipairs({ 'b', 'c', 'i', 'r', 't' }) do
        pcall(vim.keymap.del, 'n', '<leader>' .. key, { buffer = 0 })
    end
end)
