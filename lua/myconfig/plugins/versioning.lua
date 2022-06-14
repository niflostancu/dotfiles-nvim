--[[
  Version Control System (e.g., git / hg) integration plugins.
]]

lvim.builtin.nvimtree.setup.renderer.icons.git_placement = "after"

-- Neogit - Magit clone for Nvim
lvimPlugin({
  "TimUntersberger/neogit",
  requires = {'nvim-lua/plenary.nvim', "sindrets/diffview.nvim" },
  config = function()
    require('neogit').setup({
      integrations = { diffview = true }
    })
  end
})

lvim.builtin.which_key.mappings["g"]["s"] = {
  function() require('neogit').open({ kind = "split" }) end,
  "[Neogit] Open (split)"
}
lvim.builtin.which_key.mappings["g"]["c"] = {
  function() require('neogit').open({ "commit", kind = "split" }) end,
  "[Neogit] Open (split)"
}
lvim.builtin.which_key.mappings["g"]["l"] = {
  function() require('neogit').open({ "log", kind = "split" }) end,
  "[Neogit] Open (split)"
}

-- Whole-tab diff view
lvimPlugin {
  "sindrets/diffview.nvim",
  requires = {'nvim-lua/plenary.nvim'},
  config = function()
    require('diffview').setup({})
  end
}

-- The classic Fugitive plugin
lvimPlugin({
  "tpope/vim-fugitive",
  cmd = {
    "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete",
    "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
  },
  ft = { "fugitive" }
})

