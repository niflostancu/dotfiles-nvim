return {
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },

  { "HiPhish/jinja.vim" },
  {
    -- TreeSitter grammars for Jinja, Packer HCL
    "AstroNvim/astrocore",
    opts = function(_, opts)
      require("myconfig.utils").ensure_installed(opts.treesitter,
        { "jinja", "hcl" })
    end,
  },
}

