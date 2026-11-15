local M = {}

local staging_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'local', 'start')

local function valid_name(name)
    return name ~= '.' and name ~= '..' and name:match('^[%w._-]+$') ~= nil
end

local function notify(message, level)
    vim.notify('Local plugins: ' .. message, level or vim.log.levels.INFO)
end

local function staged_links()
    local links = {}
    if not vim.uv.fs_stat(staging_dir) then
        return links
    end
    for name in vim.fs.dir(staging_dir) do
        local path = vim.fs.joinpath(staging_dir, name)
        local stat = vim.uv.fs_lstat(path)
        if stat and stat.type == 'link' then
            links[name] = path
        end
    end
    return links
end

local function stage(opts)
    if #opts.fargs > 2 then
        notify('Usage: PackStage {directory} [name]', vim.log.levels.ERROR)
        return
    end

    local source = vim.fs.normalize(vim.fn.fnamemodify(opts.fargs[1], ':p'))
    local name = opts.fargs[2] or vim.fs.basename(source)
    if not name or not valid_name(name) then
        notify('Name must contain only letters, digits, dots, underscores, or hyphens (except . and ..).',
            vim.log.levels.ERROR)
        return
    end
    local stat = vim.uv.fs_stat(source)
    if not stat or stat.type ~= 'directory' then
        notify('Not a directory: ' .. source, vim.log.levels.ERROR)
        return
    end

    local destination = vim.fs.joinpath(staging_dir, name)
    local existing, stat_error, stat_code = vim.uv.fs_lstat(destination)
    if existing then
        if existing.type == 'link' and vim.uv.fs_realpath(destination) == vim.uv.fs_realpath(source) then
            notify(name .. ' is already staged. Restart Neovim to load it.')
        else
            notify('Destination already exists: ' .. destination .. '. Unstage it first if it is a symlink.',
                vim.log.levels.ERROR)
        end
        return
    end
    if stat_code ~= 'ENOENT' then
        notify('Cannot inspect destination: ' .. tostring(stat_error), vim.log.levels.ERROR)
        return
    end

    local ok, err = pcall(vim.fn.mkdir, staging_dir, 'p')
    if not ok then
        notify('Cannot create staging directory: ' .. tostring(err), vim.log.levels.ERROR)
        return
    end
    local linked, link_error = vim.uv.fs_symlink(source, destination, { dir = true })
    if not linked then
        notify('Cannot create symlink: ' .. tostring(link_error), vim.log.levels.ERROR)
        return
    end
    notify(('Staged %s -> %s. Restart Neovim to load it.'):format(name, source))
end

local function unstage(opts)
    local name = opts.args
    if not valid_name(name) then
        notify('Invalid plugin name: ' .. name, vim.log.levels.ERROR)
        return
    end
    local path = vim.fs.joinpath(staging_dir, name)
    local stat, err = vim.uv.fs_lstat(path)
    if not stat then
        notify('Cannot inspect ' .. path .. ': ' .. tostring(err), vim.log.levels.ERROR)
        return
    end
    if stat.type ~= 'link' then
        notify('Refusing to remove a non-symlink: ' .. path, vim.log.levels.ERROR)
        return
    end
    local removed, unlink_error = vim.uv.fs_unlink(path)
    if not removed then
        notify('Cannot remove symlink: ' .. tostring(unlink_error), vim.log.levels.ERROR)
        return
    end
    notify('Unstaged ' .. name .. '. Restart Neovim to restore normal loading.')
end

-- :PackStage ~/projects/my-plugin.nvim
-- :PackStage ~/projects/local-colors catppuccin.nvim
-- Escape spaces in directory names with a backslash, as with :edit.
-- :PackUnstage my-plugin.nvim
-- Restart after staging or unstaging. New plugins still need their usual setup.
vim.api.nvim_create_user_command('PackStage', stage, {
    desc = 'Stage a local plugin: PackStage {directory} [name], then restart',
    nargs = '+',
    complete = 'dir',
    force = true,
})

vim.api.nvim_create_user_command('PackUnstage', unstage, {
    desc = 'Remove a local plugin symlink, then restart',
    nargs = 1,
    complete = function(prefix)
        local names = {}
        for name in pairs(staged_links()) do
            if vim.startswith(name, prefix) then
                names[#names + 1] = name
            end
        end
        table.sort(names)
        return names
    end,
    force = true,
})

function M.filter(plugins)
    local staged = {}
    for name, path in pairs(staged_links()) do
        local stat = vim.uv.fs_stat(path)
        if stat and stat.type == 'directory' then
            staged[name] = true
        else
            vim.schedule(function()
                notify('Ignoring broken staging link: ' .. path, vim.log.levels.WARN)
            end)
        end
    end

    return vim.tbl_filter(function(spec)
        local src = type(spec) == 'string' and spec or spec.src
        local name = type(spec) == 'table' and spec.name or nil
        name = name or src:gsub('%.git$', ''):match('[^/]+$')
        return not staged[name]
    end, plugins)
end

return M
