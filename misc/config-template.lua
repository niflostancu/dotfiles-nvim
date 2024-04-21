-- Custom ("myconfig") LunarVim configuration loader

-- Path to personalized config repository
_G["myconfigpath"] = "{MYCONFIGPATH}"
-- Load custom lvim config from myconfigpath:
vim.opt.rtp:prepend(_G["myconfigpath"])
require('myconfig')

-- E.g., per-machine overrides here, e.g.:

-- lvim.lsp.installer.setup.automatic_installation.exclude = {
-- 	"clangd", "intelephense"
-- }

