local M = {}

--- A "smart" quit function
---
--- The "smarts":
--- * When there are multiple open windows, close the window.
--- * When there is only one open window, close the buffer.
--- * When the last buffer has been closed, exit nvim.
--- * TODO: don't close splits for 'buflisted' buffers
---
--- @usage require("core.util.quit")
function M.smart()
    local filter_open_buffers = function(bufnr)
        return
            vim.api.nvim_buf_is_valid(bufnr)           -- i.e. buffer exists
            and vim.api.nvim_buf_is_loaded(bufnr)      -- i.e. buffer not empty  (:h api-buffer)
            and vim.fn.buflisted(bufnr) == 1           -- i.e. not help docs (:h 'buflisted')
            and vim.api.nvim_buf_get_name(bufnr) ~= "" -- i.e. not the default buffer
    end

    local open_windows = vim.api.nvim_list_wins()
    local open_buffers = vim.tbl_filter(filter_open_buffers, vim.api.nvim_list_bufs())

    if #open_windows > 1 or #open_buffers == 0 then
        vim.cmd("quit") -- close window
    else
        vim.cmd("bwipe") -- close buffer
    end
end

return M
