local util = require('config.util')

-- Flip to use the CLI helper in a toggleterm float instead of boomer.nvim.
local llm_use_boomer = true

-- Hide the chat window while keeping its buffer and agent session alive.
-- Returns true if a window was hidden.
local function hide_boomer()
    local status = require('boomer').status()
    if not status then
        return false
    end
    local windows = vim.fn.win_findbuf(status.buf)
    for _, win in ipairs(windows) do
        vim.api.nvim_win_close(win, true)
    end
    return #windows > 0
end

local function llm_command()
    if util.has_executable('agency') then
        return 'agency copilot  --model claude-opus-5.5 --effort high --yolo'
    elseif util.has_executable('copilot') then
        return 'copilot --model claude-opus-5.5 --effort high'
    elseif util.has_executable('codex') then
        return 'codex -c tui.animations=false -c tui.show_tooltips=false -c check_for_update_on_startup=false'
    end
end

local function close_terminal(id)
    local terminal = require('toggleterm.terminal').get(id)
    if terminal and terminal:is_open() then
        terminal:close()
    end
end

-- Toggle terminal 1 (CLI helper) or 2 (scratch), hiding whatever else is open.
local function toggle_terminal(id)
    close_terminal(3 - id)
    hide_boomer()

    local terminals = require('toggleterm.terminal')
    if id ~= 1 or terminals.get(1) then
        vim.cmd(id .. 'ToggleTerm direction=float')
        return
    end

    local command = llm_command()
    if not command then
        vim.notify('LLM executable not found in PATH', vim.log.levels.ERROR)
        return
    end
    terminals.Terminal:new({
        cmd = command,
        count = 1,
        direction = 'float',
        auto_scroll = false,
    }):toggle()
end

local function toggle_llm()
    vim.cmd.stopinsert()
    if not llm_use_boomer then
        toggle_terminal(1)
    elseif not hide_boomer() then
        close_terminal(2)
        require('boomer').open()
    end
end

-- toggleterm.nvim: bind each hotkey to a fixed terminal id so it always toggles
-- exactly that terminal. The default "smart" open_mapping restores the last-used
-- terminal view, which let the <c-/> work terminal hijack the <c-\> Copilot key.
require('toggleterm').setup({})

-- <c-_> is the byte many terminals send for <c-/>; map both for portability.
for _, lhs in ipairs({ '<a-\\>', '<c-\\>' }) do
    util.keymap({ 'n', 'i', 't' }, lhs, toggle_llm, { desc = 'Toggle LLM helper' })
end
for _, lhs in ipairs({ '<c-/>', '<c-_>' }) do
    util.keymap({ 'n', 't' }, lhs, function() toggle_terminal(2) end)
end
