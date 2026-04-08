-- Utility Lua functions regarding session management.
local M = {}

function M.dirsess_opts()
  -- return currently loaded session dir if any, otherwise the working directory
  local Path = require("plenary.path")
  local session_dir = Path:new(vim.fn.getcwd()):absolute()
  local session_info = require("resession").get_current_session_info()
  if session_info and session_info["dir"] then
    session_dir = session_info["dir"]
  end
  return { dir = session_dir }
end

return M
