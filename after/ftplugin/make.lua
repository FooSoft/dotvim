local util = require('config.util')

for i, v in ipairs({'sources', 'sources.inc', 'dirs'}) do
    if v == util.buffer_name() then
        vim.bo.expandtab = true
        break
    end
end
