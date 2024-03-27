local function invoke(args)
    output = vim.fn.system(table.concat(args, ' '))
    return string.gsub(output, '%s+$', '')
end

local function get_branch_parent()
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

local function edit_git_paths(names)
    local root_dir = invoke({'git', 'rev-parse', '--show-toplevel'})
    for name in string.gmatch(names, '[^\r\n]+') do
        vim.cmd(string.format('e %s/%s', root_dir, name))
    end
end

-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx)
        vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g')
    end,
    {range = '%'}
)

-- Conflicts
vim.api.nvim_create_user_command(
    'Conflicts',
    function(ctx)
        edit_git_paths(invoke({'git', 'diff', '--name-only', '--diff-filter=U'}))
    end,
    {}
)

-- TopicEdit
vim.api.nvim_create_user_command(
    'TopicEdit',
    function(ctx)
        local hash = get_branch_parent()
        if hash then
            edit_git_paths(invoke({'git', 'diff', '--name-only', hash}))
        end
    end,
    {}
)

-- TopicDiff
vim.api.nvim_create_user_command(
    'TopicDiff',
    function(ctx)
        local hash = get_branch_parent()
        if hash then
            invoke({'git', 'difftool', '-d', hash})
        end
    end,
    {}
)
