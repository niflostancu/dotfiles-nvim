--[[
  Personalized LunarVim configuration file - entrypoint.
]]

_G.myconfig = {}

require("myconfig.utils.plugins")

lvim.log.level = "warn"
-- use for debugging
--lvim.log.level = "debug"

-- replace LunarVim's config path with ours
function _G.get_config_dir()
  return _G.myconfigpath
end
-- also move the NVIM manifest inside LunarVim's runtime dir
vim.env.NVIM_RPLUGIN_MANIFEST = _G.join_paths(_G.get_runtime_dir(), "rplugin.vim")

myconfigroup = "_myconfig_"
vim.api.nvim_create_augroup(myconfigroup, {})

vim.opt.rtp:append(_G.join_paths(_G.myconfigpath, "after"))

-- modular files for each aspect of [Lunar]Vim's configuration
require("myconfig.theme")
require("myconfig.gui")
require("myconfig.tweaks")
require("myconfig.keymappings")
require("myconfig.plugins")
require("myconfig.lang")

-- TODO: inspect / steal from https://github.com/askfiy/nvim
-- TODO: https://github.com/abzcoding/lvim
-- TODO: goodies https://github.com/echasnovski/mini.nvim
-- ... and: https://github.com/rockerBOO/awesome-neovim

