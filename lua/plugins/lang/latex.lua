return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) require("myconfig.utils").ensure_installed(opts, { "typst", "vim" }) end,
  },
}

