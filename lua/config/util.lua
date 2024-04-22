-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx)
        vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g')
    end,
    {range = '%'}
)

local function invoke(args)
    local output = vim.fn.system(table.concat(args, ' '))
    return string.gsub(output, '%s+$', '')
end

local function git_parent_branch(parent_branch)
    if parent_branch ~= '' then
        return parent_branch
    end

    local author = invoke({'git', 'config', 'user.name'})
    if #author == 0 then
        print('User name is not set')
        return
    end

    local hash = invoke{
        'git',
        'log',
        '-n1',
        '--author="^((?!' .. author .. ').)*$"',
        '--perl-regexp',
        '--pretty=format:"%H"'
    }

    if #hash == 0 then
        print('All commits are by current author')
    else
        return hash
    end
end

local function git_edit_paths(names)
    local root_dir = invoke({'git', 'rev-parse', '--show-toplevel'})
    for name in string.gmatch(names, '[^\r\n]+') do
        vim.cmd(string.format('e %s/%s', root_dir, name))
    end
end

-- GitConflicts
vim.api.nvim_create_user_command(
    'GitConflicts',
    function()
        git_edit_paths(invoke({'git', 'diff', '--name-only', '--diff-filter=U'}))
    end,
    {}
)

-- GitTopicEdit
vim.api.nvim_create_user_command(
    'GitTopicEdit',
    function(ctx)
        local hash = git_parent_branch(ctx.args)
        if hash then
            git_edit_paths(invoke({'git', 'diff', '--name-only', hash}))
        end
    end,
    {nargs = '?'}
)

-- GitTopicDiff
vim.api.nvim_create_user_command(
    'GitTopicDiff',
    function(ctx)
        local hash = git_parent_branch(ctx.args)
        if hash then
            invoke({'git', 'difftool', '-d', hash})
        end
    end,
    {nargs = '?'}
)
