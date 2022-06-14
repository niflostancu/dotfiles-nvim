-- Include user configs

_G.myconfigpath = "/home/niflo/Documents/Personal/Configs/lunarvim-config/"

vim.opt.rtp:prepend(_G.myconfigpath)

require('myconfig')

