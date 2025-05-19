local buf = vim.api.nvim_win_get_buf(0)
if vim.bo[buf].readonly then
    return
end

vim.opt_local.spell = true
vim.opt_local.wrap = true

if vim.fn.has('win32') == 1 then
    vim.opt_local.fileformat = 'dos'
end
