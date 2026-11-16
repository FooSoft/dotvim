local util = require('config.util')
local pack_local = require('config.pack_local')

local plugins = {
    'https://git.sr.ht/~foosoft/argonaut.nvim',
    'https://git.sr.ht/~foosoft/boomer.nvim',
    'https://git.sr.ht/~foosoft/f5.nvim',
    'https://git.sr.ht/~foosoft/guid.nvim',
    'https://git.sr.ht/~foosoft/revolver.nvim',
    'https://github.com/airblade/vim-rooter.git',
    'https://github.com/akinsho/toggleterm.nvim.git',
    'https://github.com/christoomey/vim-sort-motion.git',
    'https://github.com/dlyongemallo/diffview-plus.nvim',
    'https://github.com/junegunn/vim-easy-align.git',
    'https://github.com/justinmk/vim-dirvish.git',
    'https://github.com/lewis6991/gitsigns.nvim.git',
    'https://github.com/michaeljsmith/vim-indent-object.git',
    'https://github.com/ntpeters/vim-better-whitespace.git',
    'https://github.com/t9md/vim-quickhl.git',
    'https://github.com/tpope/vim-abolish.git',
    'https://github.com/tpope/vim-dispatch.git',
    'https://github.com/tpope/vim-jdaddy.git',
    'https://github.com/tpope/vim-repeat',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-unimpaired.git',
    { src = 'https://github.com/catppuccin/nvim.git', name = 'catppuccin.nvim' },
}

if util.has_executable('fzf') then
    table.insert(plugins, 'https://github.com/ibhagwan/fzf-lua.git')
end

if util.is_unix() then
    table.insert(plugins, 'https://github.com/lambdalisue/suda.vim.git')
end

-- Local start packages expose Lua modules during init and load scripts at startup.
vim.pack.add(pack_local.filter(plugins), { confirm = false, load = true })

vim.api.nvim_create_user_command(
    'PackUpdate',
    function() vim.pack.update() end,
    { desc = 'Review updates for all managed plugins', force = true }
)

vim.api.nvim_create_user_command('PackDelete', function(opts)
    vim.pack.del({ opts.args })
end, {
    desc = 'Delete a managed plugin',
    nargs = 1,
    complete = function(prefix)
        local names = {}
        for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
            if vim.startswith(plugin.spec.name, prefix) then
                table.insert(names, plugin.spec.name)
            end
        end
        table.sort(names)
        return names
    end,
    force = true,
})
