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
    local output = vim.fn.system(table.concat(args, ' '))
    return string.gsub(output, '%s+$', '')
end

local function git_delete_lock()
    local root = invoke({'git', 'rev-parse', '--show-toplevel'})
    local lock_path = root .. '/.git/index.lock'
    vim.fn.delete(lock_path)
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

-- GitUnlock
vim.api.nvim_create_user_command('GitUnlock', git_delete_lock, {})

-- UnAlign
vim.api.nvim_create_user_command('UnAlign', unalign, {range = '%'})

-- BuffDeleteAllButCurrent
vim.api.nvim_create_user_command('BuffDeleteAllButCurrent', buff_delete_all_but_current, {})

return {
    keymap = keymap
}
