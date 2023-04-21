--[[
  File explorer / tree plugins and configuration.
]]

-- use per-tab working directories
lvim.builtin.project.scope_chdir = "tab"

-- remove package files, add pseudo '.vim-root' for manual overrides
lvim.builtin.project.patterns = {
  ".git", ".hg", ".bzr", ".svn", ".vim-root"
}

-- nvimtree plugin personalization
local nvimtree_overrides = {
  -- UI tweaks
  diagnostics = {enable = false},
  renderer = {icons = {git_placement = "after"}},
  view = {side = "left", signcolumn = 'no' },
  -- settings for tab-based workflow / Project.nvim integration
  actions = {change_dir = {enable = false}},
  sync_root_with_cwd = true,
  reload_on_bufenter = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = { "", "fzf", "help", "qf", "lspinfo", "undotree" },
  },
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

  local function nvimtree_cd()
    -- TODO: override project dir (per tab) on manual nvim-tree CD
    local node = api.tree.get_node_under_cursor()
    vim.cmd('tcd ' .. node.absolute_path)
    api.tree.change_root_to_node(node)
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Node'))
  vim.keymap.set('n', '<S-h>', "<Cmd>tabprevious<CR>", opts('Previous Tab'))
  vim.keymap.set('n', 'C', nvimtree_cd, opts('CD'))
  vim.keymap.set('n', '<C-e>', nvimtree_open_in_nvr, opts('Open in NVR instance'))
  vim.keymap.set('n', '<Tab>', nvimtree_open_in_nvr, opts('Open in NVR instance'))
end

nvimtree_overrides.on_attach = nvim_tree_attach

-- enable lualine's nvim-tree integration
lvim.builtin.lualine.extensions = { "nvim-tree" }

lvim.builtin.nvimtree.setup = vim.tbl_deep_extend("force", lvim.builtin.nvimtree.setup, nvimtree_overrides)

-- lvim.builtin.nvimtree.on_config_done = function()
--   lvim.builtin.nvimtree.setup = vim.tbl_deep_extend("force", lvim.builtin.nvimtree.setup, nvimtree_overrides)
--   require("nvim-tree").setup(lvim.builtin.nvimtree.setup)
-- end

