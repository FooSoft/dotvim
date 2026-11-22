local util = require('config.util')
local pack_local = require('config.pack_local')

local plugins = {
    'https://github.com/FooSoft/argonaut.nvim',
    'https://github.com/FooSoft/boomer.nvim',
    'https://github.com/FooSoft/guid.nvim',
    'https://github.com/FooSoft/revolver.nvim',
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

-- Removes installed plugins but keeps the lockfile, so they reinstall at the locked revisions on next start.
vim.api.nvim_create_user_command('PackClear', function()
    local plug_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site', 'pack', 'core')
    if vim.fn.confirm('Delete all installed plugins in ' .. plug_dir .. '?', '&Yes\n&No', 2) ~= 1 then
        return
    end
    if vim.fn.delete(plug_dir, 'rf') ~= 0 then
        vim.notify('Cannot delete ' .. plug_dir, vim.log.levels.ERROR)
        return
    end
    vim.notify('Cleared installed plugins. Restart Neovim to reinstall them.')
end, { desc = 'Delete all installed plugins so they reinstall on next start', force = true })

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
