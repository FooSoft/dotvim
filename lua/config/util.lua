local function invoke(args)
    output = vim.fn.system(table.concat(args, ' '))
    return string.gsub(output, '%s+$', '')
end

local function get_branch_parent()
    local author = invoke({'git', 'config', 'user.name'})

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

-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx)
        vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g')
    end,
    {range = '%'}
)

-- TopicEdit
vim.api.nvim_create_user_command(
    'TopicEdit',
    function(ctx)
        local hash = get_branch_parent()
        if hash then
            local names = invoke({'git', 'diff', '--name-only', hash})
            if #names == 0 then
                print('No files changed since previous author')
            else
                local root_dir = invoke({'git', 'rev-parse', '--show-toplevel'})
                for name in string.gmatch(names, '[^\r\n]+') do
                    vim.cmd(string.format('e %s/%s', root_dir, name))
                end
            end
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
