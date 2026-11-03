local P = require "myconfig.profile"
if not P.has("lang.python") then return {} end

return {
  { import = "astrocommunity.pack.python" },
  {
    "neolooong/whichpy.nvim",
    dependencies = {
      "folke/snacks.nvim",
      -- "mfussenegger/nvim-dap-python",
    },
    opts = {},
  },
}
