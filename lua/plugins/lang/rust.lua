-- Rust-related related plugins
local P = require "myconfig.profile"
if not P.has("lang.rust") then return {} end

return {
  { import = "astrocommunity.pack.rust" },
}

