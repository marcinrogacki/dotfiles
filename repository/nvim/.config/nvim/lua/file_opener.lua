--[[
file_opener.lua
----------------
Extends Neovim's :edit (:e) command so you can open a file directly at a specific
line and column using the syntax:

    :e path/to/file:line:column
    :e path/to/file:line

Features:
- Works with absolute and relative file paths
- Jumps directly to given line and column
- Defaults column to 1 if omitted
- Warns if the file does not exist
- Clamps line/column to valid range to avoid "Cursor position outside buffer" errors
- Falls back to normal :e behavior when no position is given

Examples:
    :e src/main.ts:42:7      -- open at line 42, column 7
    :e src/main.ts:42        -- open at line 42, column 1
    :e missing.ts:10         -- shows "File not found" error
    :e src/main.ts           -- behaves like normal :e

Author: ChatGPT
--]]

local M = {}

--- Open a file at a specific line and column.
-- @param path_with_pos string: "file:line:col" or "file:line"
function M.edit_with_position(path_with_pos)
  -- Try matching file:line:col
  local file, line, col = string.match(path_with_pos, "^(.-):(%d+):(%d+)$")
  -- Try matching file:line (no column)
  if not file then
    file, line = string.match(path_with_pos, "^(.-):(%d+)$")
    col = 1
  end

  -- If no match → normal :e behavior
  if not file then
    vim.cmd("edit " .. path_with_pos)
    return
  end

  -- File existence check
  if vim.fn.filereadable(file) == 0 then
    vim.notify("File not found: " .. file, vim.log.levels.ERROR)
    return
  end

  -- Open the file
  vim.cmd("edit " .. file)

  -- Clamp line and column to valid positions
  local bufnr = vim.api.nvim_get_current_buf()
  local last_line = vim.api.nvim_buf_line_count(bufnr)
  local target_line = math.min(tonumber(line), last_line)

  local line_text = vim.api.nvim_buf_get_lines(bufnr, target_line - 1, target_line, false)[1] or ""
  local last_col = #line_text
  local target_col = math.min(tonumber(col) - 1, last_col)

  -- Move cursor to target position
  vim.api.nvim_win_set_cursor(0, { target_line, target_col })
end

return M
