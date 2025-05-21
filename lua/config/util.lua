local function keymap(mode, lhs, rhs, opts)
    local default_opts = {
        silent = true,
        noremap = true,
    }

    vim.keymap.set(
        mode,
        lhs,
        rhs,
        vim.tbl_deep_extend(
            'force',
            default_opts,
            opts or {}
        )
    )
end

local function invoke(args)
    local result = vim.system(args, {text = true}):wait()
    if result.code == 0 then
        return result.stdout:gsub('%s+$', '')
    end
end

local function buffer_dir()
    return vim.fn.expand('%:p:h')
end

local function git_root()
    if vim.fn.executable('git') == 1 then
        return invoke({'git', '-C', buffer_dir(), 'rev-parse', '--show-toplevel'})
    end
end

local function git_delete_lock()
    local root = git_root()
    if root then
        local lock_path = root .. '/.git/index.lock'
        vim.fn.delete(lock_path)
    end
end

local function unalign(ctx)
    vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g')
end

local function buff_delete_all_but_current()
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, i in ipairs(bufs) do
        if i ~= current_buf then
            vim.api.nvim_buf_delete(i, {})
        end
    end
end

local function sensible_dir()
    return git_root() or buffer_dir()
end

-- GitUnlock
vim.api.nvim_create_user_command('GitUnlock', git_delete_lock, {})

-- UnAlign
vim.api.nvim_create_user_command('UnAlign', unalign, {range = '%'})

-- BuffDeleteAllButCurrent
vim.api.nvim_create_user_command('BuffDeleteAllButCurrent', buff_delete_all_but_current, {})

return {
    sensible_dir = sensible_dir,
    keymap = keymap,
}
