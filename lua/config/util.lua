local M = {}
local ftplugin_undos = vim._config_ftplugin_undos or {}
vim._config_ftplugin_undos = ftplugin_undos

vim.api.nvim_create_autocmd('BufWipeout', {
    group = vim.api.nvim_create_augroup('config_ftplugin_undo', { clear = true }),
    callback = function(args)
        ftplugin_undos[args.buf] = nil
    end,
})

function M.buffer_dir()
    return vim.fn.expand('%:p:h')
end

function M.is_unix()
    return vim.fn.has('unix') == 1
end

function M.is_windows()
    return vim.fn.has('win32') == 1
end

function M.has_executable(name)
    return vim.fn.executable(name) == 1
end

function M.keymap(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true }, opts or {}))
end

---@param undo string|function Vimscript cleanup command or Lua callback.
function M.undo_ftplugin(undo)
    if type(undo) == 'string' then
        local existing = vim.b.undo_ftplugin
        vim.b.undo_ftplugin = undo .. (existing and (' | ' .. existing) or '')
        return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    if not ftplugin_undos[bufnr] then
        ftplugin_undos[bufnr] = {}
        local existing = vim.b.undo_ftplugin
        -- :execute keeps the Lua command separate from existing Vimscript cleanup.
        local run = "lua require('config.util').run_ftplugin_undo()"
        vim.b.undo_ftplugin = 'execute ' .. vim.fn.string(run) .. (existing and (' | ' .. existing) or '')
    end
    table.insert(ftplugin_undos[bufnr], undo)
end

function M.run_ftplugin_undo()
    local bufnr = vim.api.nvim_get_current_buf()
    local callbacks = ftplugin_undos[bufnr] or {}
    ftplugin_undos[bufnr] = nil
    for i = #callbacks, 1, -1 do
        callbacks[i]()
    end
end

function M.relpath(source_dir, target_path)
    local windows = M.is_windows()
    local function split(path)
        path = vim.fs.normalize(path, { win = windows, expand_env = false })
        local anchor = windows and (path:match('^//[^/]+/[^/]+') or path:match('^%a:'))
            or path:match('^/') or ''
        local parts = vim.split(path:sub(#anchor + 1), '/', { trimempty = true })
        return anchor, parts
    end
    local function equal(a, b)
        return windows and a:lower() == b:lower() or a == b
    end
    local source_anchor, source = split(source_dir)
    local target_anchor, target = split(target_path)
    if not equal(source_anchor, target_anchor) then
        return target_path
    end

    local common = 0
    while common < math.min(#source, #target) and equal(source[common + 1], target[common + 1]) do
        common = common + 1
    end
    local parts = {}
    for _ = common + 1, #source do
        parts[#parts + 1] = '..'
    end
    for i = common + 1, #target do
        parts[#parts + 1] = target[i]
    end
    return #parts > 0 and table.concat(parts, '/') or '.'
end

return M
