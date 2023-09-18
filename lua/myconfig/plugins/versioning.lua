--[[
  Version Control System (e.g., git / hg) integration plugins.
]]

-- Neogit - Magit clone for Nvim
lvimPlugin({
  "NeogitOrg/neogit",
  config = function()
    require('neogit').setup({
      integrations = { diffview = true, telescope = true },
      auto_show_console = true,
      disable_builtin_notifications = true,
      kind = "floating",
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "sindrets/diffview.nvim",
  },
})

lvim.builtin.which_key.mappings["g"]["s"] = {
  function() require('neogit').open() end,
  "[Neogit] Open"
}
lvim.builtin.which_key.mappings["g"]["c"] = {
  function() require('neogit').open({ "commit" }) end,
  "[Neogit] Commit"
}
lvim.builtin.which_key.mappings["g"]["l"] = {
  function() require('neogit').open({ "log", kind = "split" }) end,
  "[Neogit] Logs (split)"
}

-- Whole-tab diff view
lvimPlugin {
  "sindrets/diffview.nvim",
  dependencies = {'nvim-lua/plenary.nvim'},
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

--- Git conflict marker highlighting + solve bindings
lvimPlugin({
  'akinsho/git-conflict.nvim',
  version = "*",
  config = function()
    require('git-conflict').setup({
      list_opener = function()
        require('trouble').open('quickfix')
      end
    })
  end
})

