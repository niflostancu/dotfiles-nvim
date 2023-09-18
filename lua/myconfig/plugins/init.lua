--[[
  Personalized plugins entrypoint.

  Note: After changing plugin config, exit and reopen LunarVim then run
  :PackerInstall and :PackerCompile. 
]]

local pluginCategories = {
  "editing", "clipboard", "find", "code_diag", "autocomplete", "versioning", "file_management",
  "ui", "session"
}

for _, name in ipairs(pluginCategories) do
  local pluginMod = require("myconfig.plugins." .. name)
end

-- Additional Plugins
-- TODO: https://github.com/rmagatti/auto-session

