-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx) vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g') end,
    {range = '%'}
)

-- GitStreak
local function git_streak()
    local function call(args)
        output = vim.fn.system(table.concat(args, ' '))
        return string.gsub(output, '%s+$', '')
    end

    local root_dir = call({'git', 'rev-parse', '--show-toplevel'})
    if #root_dir == 0 then
        return
    end

    local author = call({'git', 'config', 'user.name'})
    if #author == 0 then
        return
    end

    local hash = call{'git', 'log', '-n1', '--author="^((?!' .. author .. ').)*$"', '--perl-regexp', '--pretty=format:"%H"'}
    if #hash == 0 then
        return
    end

    local names = call({'git', 'diff', '--name-only', hash})
    if #names == 0 then
        return
    end

    for name in string.gmatch(names, '[^\r\n]+') do
        vim.cmd(string.format('e %s/%s', root_dir, name))
    end
end

vim.api.nvim_create_user_command('GitStreak', git_streak, {nargs = 0})
