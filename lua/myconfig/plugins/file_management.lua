--[[
  File explorer / tree plugins and configuration.
]]

-- builtin nvim-tree plugin, disable auto CWD modifications

local nvimtree_overrides = {
  -- UI tweaks
  diagnostics = {enable = false},
  renderer = {icons = {git_placement = "after"}},
  view = {side = "left", signcolumn = 'no' },
  -- change global (per-tab) working dir on ChangeDir action
  actions = {change_dir = {global = true}},
  sync_root_with_cwd = true,
  -- disable annoying cd on focus feature
  update_focused_file = { enable = false },
}

-- custom nvimtree mappings
local nvim_tree_attach = function(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc,
      buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  local function nvimtree_open_in_nvr()
    local node = api.tree.get_node_under_cursor()
    require('myconfig.utils.nvr').remote_open(node.absolute_path)
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Node'))
  vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-e>', nvimtree_open_in_nvr, opts('Open in NVR instance'))
  vim.keymap.set('n', '<Tab>', nvimtree_open_in_nvr, opts('Open in NVR instance'))
end

nvimtree_overrides.on_attach = nvim_tree_attach

-- enable lualine's nvim-tree integration
lvim.builtin.lualine.extensions = { "nvim-tree" }

lvim.builtin.nvimtree.on_config_done = function()
  lvim.builtin.nvimtree.setup = vim.tbl_deep_extend("force", lvim.builtin.nvimtree.setup, nvimtree_overrides)
  require("nvim-tree").setup(lvim.builtin.nvimtree.setup)
end

-- TODO: override project dir (per tab) on manual nvim-tree CD

