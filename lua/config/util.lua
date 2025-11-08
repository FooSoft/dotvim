-- locals

local function git_root()
    return vim.fs.root(0, '.git')
end

local function get_unlock()
    local root = git_root()
    if root then
        local lock_path = root .. '/.git/index.lock'
        vim.fn.delete(lock_path)
    end
end

local function unalign_text(ctx)
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

local function comment_object()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local current_row_text = vim.api.nvim_get_current_line()
    local current_row = current_cursor[1]

    for _, v in ipairs({ '--', '//', '#' }) do
        local single_col_start = current_row_text:find(v, 1, true)
        if single_col_start then
            vim.api.nvim_win_set_cursor(0, { current_row, single_col_start - 1 })
            vim.cmd('normal! v$')
            return
        end
    end

    local block_row_start = vim.fn.search('/\\*', 'bW')
    if block_row_start > 0 then
        local block_col_start = vim.fn.col('.')
        local block_row_end = vim.fn.search('\\*/', 'W')
        if block_row_end > 0 then
            local block_col_end = vim.fn.col('.')
            vim.api.nvim_win_set_cursor(0, { block_row_start, block_col_start - 1 })
            vim.cmd('normal! v')
            vim.api.nvim_win_set_cursor(0, { block_row_end, block_col_end })
            return
        end
    end

    vim.api.nvim_win_set_cursor(0, current_cursor)
end

-- commands

vim.api.nvim_create_user_command('BuffDeleteAllButCurrent', buff_delete_all_but_current, {})
vim.api.nvim_create_user_command('CommentObject', comment_object, {})
vim.api.nvim_create_user_command('GitUnlock', get_unlock, {})
vim.api.nvim_create_user_command('UnAlign', unalign_text, { range = '%' })

-- exports

local M = {}

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

function M.file_exists(path)
    return vim.fn.filereadable(path) == 1
end

function M.update_makeprg()
    local find_root = function(name)
        return vim.fs.root(0, name)
    end

    if M.is_windows() then
        local gi_build_dir = find_root('build.cmd')
        if gi_build_dir then
            vim.bo.makeprg = vim.fs.joinpath(gi_build_dir, 'build.cmd')
            return
        end

        if vim.loop.os_getenv('_NTROOT') then
            local winmake_dir = find_root('sources') or find_root('dirs')
            if winmake_dir then
                vim.opt.errorformat = [[%f(%l)\ :\ %t%*[^:]:\ %m]]
                vim.bo.makeprg = 'build.cmd -c /dir ' .. winmake_dir
                return
            end
        end
    end

    vim.bo.makeprg = 'make'
end

function M.make()
    M.update_makeprg()
    vim.cmd.Make()
end

function M.is_quickfix_visible()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'quickfix' then
            return true
        end
    end

    return false
end

function M.toggle_quickfix()
    if M.is_quickfix_visible() then
        vim.cmd.cclose()
    else
        vim.cmd.copen()
        vim.cmd.wincmd('p')
    end
end

return M
