-- Syntax / LSP configuration for PHP

require("lvim.lsp.manager").setup("intelephense", {
  init_options = {
    globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
  }
})

