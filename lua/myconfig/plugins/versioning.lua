--[[
  Version Control System (git) integration plugins.
]]

-- reset LVim's git bindings
lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff", },
  L = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
}

-- Neogit - Magit clone for Nvim (disabled)
if (false) then
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
  "[Neogit] Open" }
lvim.builtin.which_key.mappings["g"]["c"] = {
  function() require('neogit').open({ "commit" }) end,
  "[Neogit] Commit" }
lvim.builtin.which_key.mappings["g"]["l"] = {
  function() require('neogit').open({ "log", kind = "split" }) end,
  "[Neogit] Logs (split)" } end

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
  ft = { "fugitive" },
})

lvim.builtin.which_key.mappings["g"]["s"] = { "<cmd>G<cr>", "[Fugitive] Status Open" }
lvim.builtin.which_key.mappings["g"]["c"] = { "<cmd>G commit<cr>", "[Fugitive] Commit" }
lvim.builtin.which_key.mappings["g"]["l"] = { "<cmd>G log<cr>", "[Fugitive] Logs" }
lvim.builtin.which_key.mappings["g"]["t"] = {
  "<cmd>G --paginate stash list '--pretty=format:%h %as %<(10)%gd %<(76,trunc)%s'<cr>",
  "[Fugitive] Stash" }

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

-- GitHub review tools
lvimPlugin({
  'ldelossa/gh.nvim',
  config = function()
    require('litee.gh').setup({
      git_buffer_completion = true,
      keymaps = {
        open = "<CR>", goto_web = "gx",
        expand = "zo", collapse = "zc",
        goto_issue = "gd", details = "d",
        submit_comment = "<C-s>", actions = "<C-a>",
        resolve_thread = "<C-r>"
      }
    })
  end,
  dependencies = { 'ldelossa/litee.nvim' },
})
lvimPlugin({
  'ldelossa/litee.nvim',
  config = function()
    require('litee.lib').setup({icon_set = "nerd"})
  end
})

lvim.builtin.which_key.mappings["g"]["h"] = {
  name = "+Github",
  c = {
    name = "+Commits",
    c = { "<cmd>GHCloseCommit<cr>", "Close" },
    e = { "<cmd>GHExpandCommit<cr>", "Expand" },
    o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
    p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
    z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
  },
  i = {
    name = "+Issues",
    p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
  },
  l = { "<cmd>LTPanel<cr>", "Toggle Panel" },
  r = {
    name = "+Review",
    b = { "<cmd>GHStartReview<cr>", "Begin" },
    c = { "<cmd>GHCloseReview<cr>", "Close" },
    d = { "<cmd>GHDeleteReview<cr>", "Delete" },
    e = { "<cmd>GHExpandReview<cr>", "Expand" },
    s = { "<cmd>GHSubmitReview<cr>", "Submit" },
    z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
  },
  p = {
    name = "+Pull Request",
    c = { "<cmd>GHClosePR<cr>", "Close" },
    d = { "<cmd>GHPRDetails<cr>", "Details" },
    e = { "<cmd>GHExpandPR<cr>", "Expand" },
    o = { "<cmd>GHOpenPR<cr>", "Open" },
    p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
    r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
    t = { "<cmd>GHOpenToPR<cr>", "Open To" },
    z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
  },
  t = {
    name = "+Threads",
    c = { "<cmd>GHCreateThread<cr>", "Create" },
    n = { "<cmd>GHNextThread<cr>", "Next" },
    t = { "<cmd>GHToggleThread<cr>", "Toggle" },
  },
}

