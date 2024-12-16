-- Versioning Control System related configuration

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.git.fugit2-nvim" },
    { import = "astrocommunity.git.neogit" },
  },
  {
    "NeogitOrg/neogit",
    opts = {
      kind = "split",
      -- disable filewatcher (buggy behavior)
      filewatcher = { enabled = false },
      commit_select_view = {
        kind = "auto",
      },
      log_view = {
        kind = "auto",
      },
      reflog_view = {
        kind = "tab",
      },
      integrations = {
        telescope = true,
        diffview = nil,
      }
    },
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "sindrets/diffview.nvim", dependencies = {'nvim-lua/plenary.nvim'} },
      {
        "AstroNvim/astrocore", dependencies = {"lewis6991/gitsigns.nvim"},
        opts = function(_, opts)
          opts.mappings.n["<Leader>gs"] = { "<Cmd>Neogit kind=split<CR>", desc = "Neogit Status" }
        end
      },
      {
        "lewis6991/gitsigns.nvim",
        opts = function()
          local get_icon = require("astroui").get_icon
          return {
            -- DO NOT want any gitsigns-related `<Leader>g` mappings
            on_attach = function(bufnr)
              local astrocore = require "astrocore"
              local prefix, maps = "<Leader>g", astrocore.empty_map_table()
              for _, mode in ipairs { "n", "v" } do
                maps[mode][prefix] = { desc = get_icon("Git", 1, true) .. "Git" }
              end

              maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
              maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
              for _, mode in ipairs { "o", "x" } do
                maps[mode]["ig"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "inside Git hunk" }
              end

              astrocore.set_mappings(maps, { buffer = bufnr })
            end,
            worktrees = require("astrocore").config.git_worktrees,
          }
        end,
      }
    }
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete",
      "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
    },
    ft = { "fugitive" },
  },
  {
    "ldelossa/gh.nvim",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup()
        end,
      },
    },
    config = function()
      require("litee.gh").setup()
    end,
  }
}
