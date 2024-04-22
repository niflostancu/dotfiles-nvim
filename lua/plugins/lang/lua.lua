return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts) require("myconfig.utils").ensure_installed(opts, { "lua_ls" }) end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts) require("myconfig.utils").ensure_installed(opts, { "prettier", "stylua" }) end,
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
