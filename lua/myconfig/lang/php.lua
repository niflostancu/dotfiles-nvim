-- Syntax / LSP configuration for PHP

local excludes = vim.tbl_get(lvim.lsp.installer.setup, "automatic_installation", "exclude")
if not (excludes and vim.tbl_contains(excludes, "intelephense")) then
  require("lvim.lsp.manager").setup("intelephense", {
    init_options = {
      globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
    }
  })
end

