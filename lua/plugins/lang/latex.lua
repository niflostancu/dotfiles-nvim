return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {},
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      require("myconfig.utils").ensure_installed(opts.treesitter,
        { "typst", "latex" })
    end,
  },
}

