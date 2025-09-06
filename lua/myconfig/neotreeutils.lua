-- Generic utils for programmatic neo-tree plugin manipulation
local M = {}

function M.launch_live_grep(state, opts)
  return M.launch_telescope("live_grep", state, opts)
end

function M.launch_find_files(state, opts)
  return M.launch_telescope("find_files", state, opts)
end

function M.launch_telescope(func_name, state, opts)
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end
  local node = state.tree:get_node()
  local basedir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  return require("telescope.builtin")[func_name](opts)
end

return M
