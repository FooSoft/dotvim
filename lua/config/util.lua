local M = {}

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

local function split_path(path)
    local parts = {}
    for part in path:gmatch('[^/\\]+') do
        table.insert(parts, part)
    end

    return parts
end

local function slice_table(values, start, stop)
    local results = {}
    for i = start, stop or #values do
        table.insert(results, values[i])
    end

    return results
end

local function find_common_root(path_1, path_2)
    local path_1_parts = split_path(path_1)
    local path_2_parts = split_path(path_2)

    local root_parts = {}
    for i, part in ipairs(path_1_parts) do
        if part == path_2_parts[i] then
            table.insert(root_parts, part)
        else
            break
        end
    end

    if #root_parts > 0 then
        return {
            dir = root_parts,
            tail_1 = slice_table(path_1_parts, #root_parts + 1),
            tail_2 = slice_table(path_2_parts, #root_parts + 1),
        }
    end
end

-- GitUnlock
vim.api.nvim_create_user_command('GitUnlock', git_delete_lock, {})

-- UnAlign
vim.api.nvim_create_user_command('UnAlign', unalign, { range = '%' })

-- BuffDeleteAllButCurrent
vim.api.nvim_create_user_command('BuffDeleteAllButCurrent', buff_delete_all_but_current, {})

function M.buffer_dir()
    return vim.fn.expand('%:p:h')
end

function M.buffer_name()
    return vim.fn.expand('%:t')
end

function M.buffer_path()
    return vim.fn.expand('%:p')
end

function M.is_abspath(path)
    if M.is_windows() then
        return path:sub(2, 2) == ':'
    else
        return path:sub(1, 1) == '/'
    end
end

function M.is_linux()
    return vim.fn.has('unix') == 1
end

function M.is_windows()
    return vim.fn.has('win32') == 1
end

function M.has_executable(name)
    return vim.fn.executable(name) == 1
end

function M.keymap(mode, lhs, rhs, opts)
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

function M.relpath(source_dir, target_path)
    local root = find_common_root(source_dir, target_path)
    if not root then
        return target_path
    end

    local result_path = '.'
    for _ = 1, #root.tail_1 do
        result_path = vim.fs.joinpath(result_path, '..')
    end

    for _, part in ipairs(root.tail_2) do
        result_path = vim.fs.joinpath(result_path, part)
    end

    return vim.fs.normalize(result_path)
end

return M
