-- also import plugins from the `plugins.lang` subpackage
return {
  "AstroNvim/astrocommunity",
  { import = "plugins.lang" },
  {
    "polirritmico/lazy-local-patcher.nvim",
    enabled = false,
    opts = {
      patches_path = _G["myconfigpath"] .. "/patches",
    },
    ft = "lazy",
  }
}

