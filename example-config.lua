-- Include user configs
-- Copy this to and modify the path to your configs

_G.myconfigpath = vim.fs.normalize("~/Documents/lunarvim-config")

vim.opt.rtp:prepend(_G.myconfigpath)

require('myconfig')

