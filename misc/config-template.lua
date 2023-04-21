-- Include user configs

_G["myconfigpath"] = "/home/niflo/Documents/Personal/Configs/lunarvim-config/"

-- Per-machine personalization here, e.g.:

-- lvim.lsp.installer.setup.automatic_installation.exclude = {
-- 	"clangd", "intelephense"
-- }

-- Load my config
vim.opt.rtp:prepend(_G["myconfigpath"])
require('myconfig')

