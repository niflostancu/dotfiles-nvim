--[[
  Plugin-related utility functions.
]]

-- Adds a LunarVim plugin to the config table
function lvimPlugin(pluginCfg)
  table.insert(lvim.plugins, pluginCfg)
end

