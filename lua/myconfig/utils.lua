-- Utility Lua functions for my config.
local M = {}

function M.ensure_installed(opts, plugins)
  opts.ensure_installed = require("astrocore").list_insert_unique(
    opts.ensure_installed, plugins)
end

-- Returns the current visual selected text
-- from https://github.com/nvim-telescope/telescope.nvim/issues/1923
function M.get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return vim.fn.expand '<cword>' or ''
  end
end

return M
