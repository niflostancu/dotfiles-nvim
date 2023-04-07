--[[
  Personalized plugins entrypoint.

  Note: After changing plugin config, exit and reopen LunarVim then run
  :PackerInstall and :PackerCompile. 
]]

function lvimPlugin(pluginCfg)
  table.insert(lvim.plugins, pluginCfg)
end

local pluginCategories = {
  "editing", "find", "code_diag", "versioning", "file_management",
  "ui", "session"
}

for _, name in ipairs(pluginCategories) do
  local pluginMod = require("myconfig.plugins." .. name)
end

-- Additional Plugins
-- TODO: https://github.com/rmagatti/auto-session

