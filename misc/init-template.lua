-- Custom ("myconfig") NVim configuration loader (wrapper)
-- To be put inside ${XDG_CONFIG_HOME}/nvim (or your own namespace)
-- Loads the actual nvim configuration from external directory

-- Path to the actual config repository
-- (replace with full path to nvim dotfiles directory)
_G["myconfigpath"] = "<MYCONFIGPATH>"
_G["myconfigpath"] = vim.fs.normalize(_G["myconfigpath"])
-- Load custom lvim config from myconfigpath:
vim.opt.rtp:prepend(_G["myconfigpath"])

-- load the actual config's init.lua
dofile(_G["myconfigpath"] .. '/init.lua')

-- E.g., per-machine overrides here
-- require "machine-customizations"

