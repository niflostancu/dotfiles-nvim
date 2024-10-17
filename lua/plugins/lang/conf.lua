return {
  {
    "HiPhish/jinja.vim"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) require("myconfig.utils").ensure_installed(opts, { "hcl" }) end,
  },
}

