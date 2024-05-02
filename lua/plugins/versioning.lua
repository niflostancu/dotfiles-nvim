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
    "AstroNvim/astrocore",
    opts = { mappings = { n = {
      ["<Leader>gs"] = { "<Cmd>Neogit kind=split<CR>", desc = "Neogit Status" },
    } } },
  },
}
