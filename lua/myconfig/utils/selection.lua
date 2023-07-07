local M = {}

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
