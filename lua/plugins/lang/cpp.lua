-- Embedded C/C++ related plugins
local P = require "myconfig.profile"
if not P.has("lang.cpp") then return {} end

return {
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.cmake" },

  -- Raspberry Pi Pico Programmable I/O Syntax Highlighting
  {"mikebentley15/vim-pio"}
}
