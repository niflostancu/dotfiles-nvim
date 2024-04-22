-- Utility Lua functions for my config.
local M = {}

function M.ensure_installed(opts, plugins)
  opts.ensure_installed = require("astrocore").list_insert_unique(
    opts.ensure_installed, plugins)
end

return M
