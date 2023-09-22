-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx)
        vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g')
    end,
    {range = '%'}
)

-- GitStreak
vim.api.nvim_create_user_command(
    'GitStreak',
    function(ctx)
        local function call(args)
            output = vim.fn.system(table.concat(args, ' '))
            return string.gsub(output, '%s+$', '')
        end

        local root_dir = call({'git', 'rev-parse', '--show-toplevel'})
        local author = call({'git', 'config', 'user.name'})

        local hash = call{'git', 'log', '-n1', '--author="^((?!' .. author .. ').)*$"', '--perl-regexp', '--pretty=format:"%H"'}
        if #hash == 0 then
            print('All commits are by current author')
            return
        end

        local names = call({'git', 'diff', '--name-only', hash})
        if #names == 0 then
            print('No files changed since previous author')
            return
        end

        for name in string.gmatch(names, '[^\r\n]+') do
            vim.cmd(string.format('e %s/%s', root_dir, name))
        end
    end,
    {}
)
