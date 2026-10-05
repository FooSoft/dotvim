local util = require('config.util')

local base_plugins = {
    'https://git.sr.ht/~foosoft/argonaut.nvim',
    'https://git.sr.ht/~foosoft/f5.nvim',
    'https://git.sr.ht/~foosoft/guid.nvim',
    'https://git.sr.ht/~foosoft/revolver.nvim',
    'https://github.com/airblade/vim-rooter.git',
    'https://github.com/akinsho/toggleterm.nvim.git',
    'https://github.com/christoomey/vim-sort-motion.git',
    'https://github.com/junegunn/vim-easy-align.git',
    'https://github.com/justinmk/vim-dirvish.git',
    'https://github.com/lewis6991/gitsigns.nvim.git',
    'https://github.com/michaeljsmith/vim-indent-object.git',
    'https://github.com/ntpeters/vim-better-whitespace.git',
    'https://github.com/ray-x/lsp_signature.nvim.git',
    'https://github.com/t9md/vim-quickhl.git',
    'https://github.com/tpope/vim-abolish.git',
    'https://github.com/tpope/vim-commentary.git',
    'https://github.com/tpope/vim-dispatch.git',
    'https://github.com/tpope/vim-jdaddy.git',
    'https://github.com/tpope/vim-repeat',
    'https://github.com/tpope/vim-surround',
    'https://github.com/tpope/vim-unimpaired.git',
    { src = 'https://github.com/catppuccin/nvim.git', name = 'catppuccin.nvim' },
}

vim.pack.add(
    base_plugins,
    { confirm = false, load = true }
)

if util.has_executable('fzf') then
    vim.pack.add(
        { 'https://github.com/ibhagwan/fzf-lua.git' },
        { confirm = false, load = true }
    )
end

if util.is_unix() then
    vim.pack.add(
        { 'https://github.com/lambdalisue/suda.vim.git' },
        { confirm = false, load = true }
    )
end

if util.has_executable('go') then
    vim.g.go_imports_autosave = 1
    vim.g.go_diagnostics_enabled = 0
    if vim.lsp.enable and util.has_executable('gopls') then
        vim.g.go_code_completion_enabled = 0
        vim.g.go_def_mapping_enabled = 0
        vim.g.go_doc_keywordprg_enabled = 0
    end

    vim.pack.add(
        { 'https://github.com/fatih/vim-go.git' },
        { confirm = false, load = true }
    )
end

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
