-- Generic utils for programmatic neo-tree plugin manipulation
local M = {}

function M.launch_live_grep(state, opts)
  local node = state.tree:get_node()
  local basedir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
  Snacks.picker.grep({ cwd = basedir })
end

function M.launch_find_files(state, opts)
  local node = state.tree:get_node()
  local basedir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
  Snacks.picker.files({ cwd = basedir })
end

return M
