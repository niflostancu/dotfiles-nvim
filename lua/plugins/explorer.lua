--[[
  Finder plugins & mappings.
]]

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          H = false, -- preferred for tab cycling
          [">"] = "toggle_hidden",
        },
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<F3>"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" }
          maps.n[";a"] = { "<Cmd>Neotree filesystem reveal<CR>", desc = "Show in Explorer" }
        end
      },
    },
  },
}
