-- UnAlign
vim.api.nvim_create_user_command(
    'UnAlign',
    function(ctx) vim.cmd(ctx.line1 .. ',' .. ctx.line2 .. 's/\\(\\S\\+\\)\\s\\{2,\\}/\\1 /g') end,
    {range = '%'}
)
