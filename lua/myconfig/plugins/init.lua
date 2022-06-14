--[[
  Personalized plugins entrypoint.

  Note: After changing plugin config, exit and reopen LunarVim then run
  :PackerInstall and :PackerCompile. 
]]

function lvimPlugin(pluginCfg)
  table.insert(lvim.plugins, pluginCfg)
end

local pluginCategories = {
  "editing", "find", "project", "code_diag", "versioning", "ui"
}

for _, name in ipairs(pluginCategories) do
  local pluginMod = require("myconfig.plugins." .. name)
end

-- Additional Plugins
-- TODO: https://github.com/rmagatti/auto-session

