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

-- enable lualine's nvim-tree integration
lvim.builtin.lualine.extensions = { "nvim-tree" }

lvim.builtin.nvimtree.on_config_done = function()
  lvim.builtin.nvimtree.setup = vim.tbl_deep_extend("force", lvim.builtin.nvimtree.setup, nvimtree_overrides)
  require("nvim-tree").setup(lvim.builtin.nvimtree.setup)
end

-- TODO: override project dir (per tab) on manual nvim-tree CD

