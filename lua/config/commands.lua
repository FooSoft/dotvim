local util = require('config.util')

local function git_unlock()
    local result = vim.system({ 'git', '-C', util.buffer_dir(), 'rev-parse', '--path-format=absolute',
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
        vim.bo.makeprg = 'go build'
        return util.buffer_dir()
    end

    if util.is_windows() then
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
    local build_dir = update_makeprg(not opts.bang)
    if build_dir then
        -- Dispatch uses this directory for both execution and quickfix paths.
        vim.cmd.Dispatch({ args = { vim.fn['dispatch#dir_opt'](build_dir) .. '--' } })
    else
        vim.cmd.Make()
    end
end

vim.api.nvim_create_user_command('GitUnlock', git_unlock, { force = true })
vim.api.nvim_create_user_command('UpdateAndMake', update_and_make, { bang = true, force = true })
vim.api.nvim_create_user_command('ToggleQuickfix', toggle_quickfix, { force = true })
vim.api.nvim_create_user_command('UnAlign', unalign_text, { range = '%', force = true })
vim.api.nvim_create_user_command('ClearHistoryAndExit', clear_history_and_exit, { force = true })
