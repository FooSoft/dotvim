local M = {}

-- locals

local function git_root()
    return vim.fs.root(0, '.git')
end

local function git_unlock()
    local root = git_root()
    if root then
        local lock_path = root .. '/.git/index.lock'
        vim.fn.delete(lock_path)
    end
end

local function unalign_text(ctx)
    vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g')
    vim.cmd.nohlsearch()
end

local function clear_history_and_exit()
    vim.cmd([[set vi+='0 | wv! | q!]])
end

local split_path = function(path)
    local parts = {}
    for part in path:gmatch('[^/\\]+') do
        table.insert(parts, part)
    end

    return parts
end

local slice_table = function(values, start, stop)
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

local function toggle_quickfix()
    local visible = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'quickfix' then
            visible = true
            break
        end
    end

    if visible then
        vim.cmd('cclose')
    else
        vim.cmd('botright copen | wincmd p')
    end
end

local function update_makeprg(fast)
    local find_root = function(name)
        return vim.fs.root(0, name)
    end

    if vim.api.nvim_get_option_value('filetype', { buf = 0 }) == 'go' then
        vim.bo.makeprg = 'cd ' .. M.buffer_dir() .. ' && go build'
        return
    end

    if M.is_windows() then
        local gi_build_dir = find_root('build.cmd')
        if gi_build_dir then
            vim.bo.makeprg = vim.fs.joinpath(gi_build_dir, 'build.cmd --noarm64'):gsub('/', '\\')
            if fast then
                vim.bo.makeprg = vim.bo.makeprg .. ' --noconfigure --noinstall'
            end
            return
        end

        if vim.loop.os_getenv('_NTROOT') then
            local winmake_dir = find_root('sources') or find_root('dirs')
            if winmake_dir then
                vim.bo.errorformat = [[%f(%l)\ :\ %t%*[^:]:\ %m]]
                vim.bo.makeprg = 'build.cmd -c /dir ' .. winmake_dir
                if fast then
                    vim.bo.makeprg = vim.bo.makeprg .. ' -p'
                end
                return
            end
        end
    end

    vim.bo.errorformat = nil
    vim.bo.makeprg = nil
end

local function make(opts)
    update_makeprg(not opts.bang)
    vim.cmd('wa | make | botright cwindow | silent! cc')
end

-- commands

vim.api.nvim_create_user_command('GitUnlock', git_unlock, {})
vim.api.nvim_create_user_command('Make', make, { bang = true })
vim.api.nvim_create_user_command('ToggleQuickfix', toggle_quickfix, {})
vim.api.nvim_create_user_command('UnAlign', unalign_text, { range = '%' })
vim.api.nvim_create_user_command('ClearHistoryAndExit', clear_history_and_exit, {})

-- exports

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

return M
