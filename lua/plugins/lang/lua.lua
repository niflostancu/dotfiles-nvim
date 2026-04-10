return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua-language-server",
        "stylua",
        "prettier",
      })
      for k,v in ipairs(opts.ensure_installed) do
        if v == 'selene' then
          table.remove(opts.ensure_installed, k)
          break
        end
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts) require("myconfig.utils").ensure_installed(opts, { "lua", "vim" }) end,
  },
  -- LuaLS config for nvim Lazy dotfiles
  {
    "folke/lazydev.nvim",
    ft = "lua",  -- only load on lua files
    cmd = 'LazyDev',
    opts = {
      library = {
        vim.env.VIMRUNTIME,
        _G["myconfigpath"] .. "/lua",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
}
