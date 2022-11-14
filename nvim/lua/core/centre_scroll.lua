vim.g.centre_scroll_enabled = true

-- todo(cbochs): percentage should work with both 0.0 (free) and 0.5 (fixed)
local percentage = 0.30
local percentage_top = percentage
local percentage_bot = 1.0 - percentage

local scroll_up = vim.api.nvim_replace_termcodes("<c-y>", true, false, true)
local scroll_down = vim.api.nvim_replace_termcodes("<c-e>", true, false, true)

local prev_cutoff_line_top = nil
local prev_cutoff_line_bot = nil
local prev_cursor_line = nil

local Direction = {
    Up = 1,
    Down = 2,
}

vim.api.nvim_create_augroup("CentreCursor", { clear = true })

vim.api.nvim_create_autocmd("BufLeave", {
    group = "CentreCursor",
    callback = function()
        if not vim.g.centre_scroll_enabled then
            return
        end

        prev_cutoff_line_top = nil
        prev_cutoff_line_bot = nil
        prev_cursor_line = nil
    end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    group = "CentreCursor",
    callback = function()
        if not vim.g.centre_scroll_enabled then
            return
        end

        local cursor_line = vim.fn.line(".")
        if cursor_line == prev_cursor_line then
            return
        end

        -- Use vim.o.lines instead of vim.fn.line("w$") to account for virtual
        -- buffer scrolloff past a file's end-of-file
        local window_line_top = vim.fn.line("w0")
        local window_line_bot = window_line_top + vim.o.lines - 2
        -- local window_line_bot = vim.fn.line("w$")

        local visible_lines = window_line_bot - window_line_top
        local cutoff_line_top = window_line_top + math.floor(percentage_top * visible_lines)
        local cutoff_line_bot = window_line_top + math.ceil(percentage_bot * visible_lines)
        assert(cutoff_line_top <= cutoff_line_bot, "Cutoff lines must not cross over")

        if not prev_cursor_line then
            prev_cutoff_line_top = cutoff_line_top
            prev_cutoff_line_bot = cutoff_line_bot
            prev_cursor_line = cursor_line
            return
        end

        local direction
        local distance
        local scroll_key

        -- Determine the direction of the cursor move
        local displacement = cursor_line - prev_cursor_line
        if displacement < 0 then
            direction = Direction.Up
            scroll_key = scroll_up
        elseif displacement > 0 then
            direction = Direction.Down
            scroll_key = scroll_down
        end

        -- Has the window scrolled so that the curoff lines are now different?
        local window_moved = cutoff_line_top ~= prev_cutoff_line_top and cutoff_line_bot ~= prev_cutoff_line_bot

        -- Has the cursor moved down or up INTO the centre of the previous
        -- window boundaries?
        local cursor_in_prev_centre = cursor_line > prev_cutoff_line_top and cursor_line < prev_cutoff_line_bot
        local cursor_in_centre = cursor_line > cutoff_line_top and cursor_line < cutoff_line_bot

        -- window_moved | cursor_in_prev_centre | cursor_in_centre | align with
        -- false        | false                 | false            | new boundaries or small move
        -- false        | false                 | true             | nothing
        -- false        | true                  | false            | displacement
        -- false        | true                  | true             | nothing
        -- true         | false                 | false            | new boundaries
        -- true         | false                 | true             | nothing
        -- true         | true                  | false            | old boundaries
        -- true         | true                  | true             | nothing
        --
        -- Assumptions:
        -- - A "small" adjustment using just the displacement is only possible
        --   when the previous cursor was centred, but the current cursor is not
        --
        -- Handle the cases when the cursor moves:
        -- 1. When the cursor is in neither the current window boundaries and
        --    also not in the previous window boundaries. REALIGN using the
        --    criteria:
        --    - Was the previous cursor centred? (i.e. in the middle of the
        --    window, not at the extremeties).
        --    - If YES, REALIGN using the displacement
        --    - If NO, REALIGN using the new window boundaries
        --
        -- 2. The case where the cursor moves INTO or WITHIN the centre of the
        --    previous window boundaries, but is not in the new window
        --    boundaries. REALIGN using the previous window boundaries
        --
        -- 3. All other cases, do scroll the window
        --
        if not cursor_in_centre and not cursor_in_prev_centre then
            local prev_cursor_in_centre = prev_cursor_line > cutoff_line_top and prev_cursor_line < cutoff_line_bot
            if prev_cursor_in_centre and not window_moved then
                distance = math.abs(displacement)
            else
                if direction == Direction.Up then
                    distance = math.abs(cutoff_line_top - prev_cutoff_line_top)
                elseif direction == Direction.Down then
                    distance = math.abs(cutoff_line_bot - prev_cutoff_line_bot)
                end
            end
        elseif not cursor_in_centre and cursor_in_prev_centre then
            if window_moved then
                if direction == Direction.Up then
                    distance = math.abs(cutoff_line_top - prev_cutoff_line_top)
                    scroll_key = scroll_down
                elseif direction == Direction.Down then
                    distance = math.abs(cutoff_line_bot - prev_cutoff_line_bot)
                    scroll_key = scroll_up
                end
            else
                distance = math.abs(displacement)
            end
        else
            distance = 0
        end

        if distance == nil then
            error("This should not happen with cusor movement")
        elseif distance > 0 then
            vim.api.nvim_feedkeys(distance .. scroll_key, "n", false)
        end

        prev_cutoff_line_top = cutoff_line_top
        prev_cutoff_line_bot = cutoff_line_bot
        prev_cursor_line = cursor_line
    end,
})
