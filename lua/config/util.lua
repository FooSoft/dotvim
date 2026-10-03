local M = {}

-- locals

local function git_unlock()
    local result = vim.system({ 'git', '-C', M.buffer_dir(), 'rev-parse', '--path-format=absolute',
        '--git-path', 'index.lock' }, { text = true }):wait()
    if result.code ~= 0 then
        vim.notify(vim.trim(result.stderr), vim.log.levels.ERROR)
        return
    end
    local lock_path = vim.trim(result.stdout)
    if vim.fn.filereadable(lock_path) == 1 and vim.fn.delete(lock_path) ~= 0 then
        vim.notify('Could not delete ' .. lock_path, vim.log.levels.ERROR)
    end
end

local function unalign_text(ctx)
    vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /ge')
    vim.cmd.nohlsearch()
end

local function clear_history_and_exit()
    vim.cmd([[set vi+='0 | wv! | q!]])
end

local function toggle_quickfix()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        vim.cmd('cclose')
    else
        vim.cmd('botright copen | wincmd p')
    end
end

local function update_makeprg(fast)
    if vim.bo.filetype == 'go' then
        vim.bo.makeprg = 'cd ' .. vim.fn.shellescape(M.buffer_dir()) .. ' && go build'
        return
    end

    if M.is_windows() then
        local gi_build_dir = vim.fs.root(0, 'build.cmd')
        if gi_build_dir then
            local build_cmd = vim.fs.joinpath(gi_build_dir, 'build.cmd'):gsub('/', '\\')
            vim.bo.makeprg = vim.fn.shellescape(build_cmd) .. ' --noarm64 --noarm64ec --nox86'
            if fast then
                vim.bo.makeprg = vim.bo.makeprg .. ' --noconfigure --noinstall'
            end
            return
        end

        if vim.env._NTROOT then
            local winmake_dir = vim.fs.root(0, { 'sources', 'dirs' })
            if winmake_dir then
                vim.bo.errorformat = [[%f(%l)\ :\ %t%*[^:]:\ %m]]
                vim.bo.makeprg = 'build.cmd -c /dir ' .. vim.fn.shellescape(winmake_dir)
                if fast then
                    vim.bo.makeprg = vim.bo.makeprg .. ' -p'
                end
                return
            end
        end
    end
end

local function update_and_make(opts)
    vim.cmd.update()
    update_makeprg(not opts.bang)
    vim.cmd.Make()
end

local function llm_terminal()
    local command
    if M.is_unix() and M.has_executable('codex') then
        command = 'codex -c tui.animations=false'
    elseif M.is_windows() then
        if M.has_executable('gif-copilot.cmd') then
            command = 'gif-copilot.cmd --noagents'
        elseif M.has_executable('agency') then
            command = 'agency copilot --yolo'
        end
    end

    if command then
        require('toggleterm.terminal').Terminal:new({
            cmd = command,
            count = 1,
            direction = 'float',
            auto_scroll = false,
        }):toggle()
    else
        vim.notify('LLM executable not found in PATH', vim.log.levels.ERROR)
    end
end

function M.toggle_copilot()
    if require('toggleterm.terminal').get(1) then
        vim.cmd('1ToggleTerm direction=float')
    else
        llm_terminal()
    end
end

-- commands

vim.api.nvim_create_user_command('GitUnlock', git_unlock, {})
vim.api.nvim_create_user_command('UpdateAndMake', update_and_make, { bang = true })
vim.api.nvim_create_user_command('ToggleQuickfix', toggle_quickfix, {})
vim.api.nvim_create_user_command('UnAlign', unalign_text, { range = '%' })
vim.api.nvim_create_user_command('ClearHistoryAndExit', clear_history_and_exit, {})

-- exports

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

function M.undo_ftplugin(command)
    local undo = vim.b.undo_ftplugin
    -- Existing undo commands may end with an :autocmd, which consumes trailing bars.
    vim.b.undo_ftplugin = 'execute ' .. vim.fn.string(command) .. (undo and (' | ' .. undo) or '')
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
