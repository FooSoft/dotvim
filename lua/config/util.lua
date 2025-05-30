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

local function buffer_path()
    return vim.fn.expand('%:p')
end

local function buffer_dir()
    return vim.fn.expand('%:p:h')
end

local function git_root()
    return vim.fs.root(0, '.git')
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

local function sensible_root()
    return git_root() or buffer_dir()
end

local function make()
    vim.o.makeprg = 'make -C ' .. sensible_root()
    vim.cmd.lmake()
end

local function is_windows()
    return vim.fn.has('win32') == 1
end

local function is_linux()
    return vim.fn.has('unix') == 1
end

local function split_path(path)
    local path_parts = {}
    for path_part in path:gmatch('[^/\\]+') do
        table.insert(path_parts, path_part)
    end

    return path_parts
end

local function find_common_root(path_1, path_2)
    local path_1_parts = split_path(path_1)
    local path_2_parts = split_path(path_2)

    local root_dir = nil
    local root_dir_part_count = 0
    for i, part in ipairs(path_1_parts) do
        if part == path_2_parts[i] then
            root_dir_part_count = root_dir_part_count + 1
            if root_dir then
                root_dir = vim.fs.joinpath(root_dir, part)
            else
                root_dir = part
            end
        else
            break
        end
    end

    if root_dir then
        return {
            rmn_1 = #path_1_parts - root_dir_part_count,
            rmn_2 = #path_2_parts - root_dir_part_count,
            dir = root_dir,
        }
    end
end

local function relpath(source_dir, target_path)
    local common_root = find_common_root(source_dir, target_path)
    if not common_root then
        return target_path
    end

    local result_path = '.'
    for _ = 1, common_root.rmn_1 do
        result_path = vim.fs.joinpath(result_path, '..')
    end

    local target_parts = split_path(target_path)
    for i = #target_parts - common_root.rmn_2 + 1, #target_parts do
        result_path = vim.fs.joinpath(result_path, target_parts[i])
    end

    return vim.fs.normalize(result_path)
end

-- GitUnlock
vim.api.nvim_create_user_command('GitUnlock', git_delete_lock, {})

-- UnAlign
vim.api.nvim_create_user_command('UnAlign', unalign, { range = '%' })

-- BuffDeleteAllButCurrent
vim.api.nvim_create_user_command('BuffDeleteAllButCurrent', buff_delete_all_but_current, {})

return {
    buffer_dir = buffer_dir,
    buffer_path = buffer_path,
    is_linux = is_linux,
    is_windows = is_windows,
    keymap = keymap,
    make = make,
    relpath = relpath,
    sensible_root = sensible_root,
}
