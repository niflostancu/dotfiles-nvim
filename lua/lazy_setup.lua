-- additional Runtime Paths (add myconfigpath since Lazy resets it!)
local additional_rtp = {}
if _G["myconfigpath"] ~= nil then table.insert(additional_rtp, _G["myconfigpath"]) end

require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  { import = "community" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "astrodark", "habamax" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      paths = additional_rtp,
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
