---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>;"] = { ":lua ", "enter command mode with lua prefix", opts = { nowait = true } },
  },
}

-- more keybinds!

return M
