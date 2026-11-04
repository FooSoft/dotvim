local util = require('config.util')

local function llm_terminal()
    local command
    if util.has_executable('agency') then
        command = 'agency copilot  --model claude-opus-5.5 --effort high --yolo'
    elseif util.has_executable('codex') then
        command = 'codex -c tui.animations=false -c tui.show_tooltips=false -c check_for_update_on_startup=false'
    end

    if command then
        require('toggleterm.terminal').Terminal:new({
            cmd = command,
            count = 1,
            direction = 'float',
            auto_scroll = false,
        }):toggle()
    else
        vim.notify('LLM executable not found in PATH', vim.log.levels.ERROR)
    end
end

local function toggle_terminal(id)
    local terminals = require('toggleterm.terminal')
    local other = terminals.get(id == 1 and 2 or 1)
    if other and other:is_open() then
        other:close()
    end

    if id == 1 and not terminals.get(1) then
        llm_terminal()
    else
        vim.cmd(id .. 'ToggleTerm direction=float')
    end
end

-- toggleterm.nvim: bind each hotkey to a fixed terminal id so it always toggles
-- exactly that terminal. The default "smart" open_mapping restores the last-used
-- terminal view, which let the <c-/> work terminal hijack the <c-\> Copilot key.
require('toggleterm').setup({})

-- LLM lives on terminal id 1 (start it / toggle it), scratch work terminal on id 2.
-- Close the other window before toggling; both terminal sessions keep running.
-- <c-_> is the byte many terminals send for <c-/>; map both for portability.
util.keymap({ 'n', 't' }, '<c-\\>', function() toggle_terminal(1) end)
for _, lhs in ipairs({ '<c-/>', '<c-_>' }) do
    util.keymap({ 'n', 't' }, lhs, function() toggle_terminal(2) end)
end
