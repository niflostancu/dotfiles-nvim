-- Versioning Control System related configuration

return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.git.fugit2-nvim" },
  },
  {
    "AstroNvim/astrocore",
    opts = { mappings = { n = {
      ["<Leader>gs"] = { "<Cmd>Fugit2<CR>", desc = "Fugit2" },
    } } },
  },
}
