return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "lua-language-server", "prettier", "stylua" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) require("myconfig.utils").ensure_installed(opts, { "lua", "vim" }) end,
  },
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
  },
}
