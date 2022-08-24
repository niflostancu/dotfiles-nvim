--[[
  Project-related editor plugins & configuration.
]]


-- TODO: nvimtree CD to override project dir (per tab)

-- lvim.builtin.nvimtree.setup.actions.change_dir = {
--   global = true,
-- }


lvim.builtin.project.patterns = {
  ".git", ".hg", ".bzr", ".svn", ".vim-root"
}

