-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx) vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g') end,
    {range = '%'}
)

-- GitStreak
local function git_streak()
    local root_dir = vim.fn.system(table.concat({'git', 'rev-parse', '--show-toplevel'}, ' '))
    root_dir = string.gsub(root_dir, '%s+$', '')
    if #root_dir == 0 then
        return
    end

    local author = vim.fn.system(table.concat({'git', 'config', 'user.name'}, ' '))
    author = string.gsub(author, '%s+$', '')

    local hash = vim.fn.system(table.concat({
        'git',
        'log',
        '-n1',
        string.format('--author="^((?!%s).)*$"', author),
        '--perl-regexp',
        '--pretty=format:"%H"'}, ' '))
    if #hash == 0 then
        return
    end

    local names = vim.fn.system(table.concat({'git', 'diff', '--name-only', hash}, ' '))
    if #names == 0 then
        return
    end

    for name in string.gmatch(names, '[^\r\n]+') do
        local path = string.format('%s/%s', root_dir, name)
        vim.cmd(string.format('e %s', path))
    end
end

vim.api.nvim_create_user_command('GitStreak', git_streak, {nargs = 0})
