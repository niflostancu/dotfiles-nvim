local P = require "myconfig.profile"
if not P.has("lang.go") then return {} end

return {
  { import = "astrocommunity.pack.go" },
}
