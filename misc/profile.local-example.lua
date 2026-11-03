-- Machine profile file. Copy this file to one of (first match wins):
--   1. ~/.config/{NVIM_APPNAME}/profile.local.lua  (outside the repo)
--   2. <repo root>/local/profile.lua               (gitignored)
-- Valid profiles: "full" | "light" | "server" (see lua/profiles.lua)
--
-- String form:
--   return "server"
--
-- Table form (profile + per-machine extra/override features;
-- `extra` shallow-merges over the profile, so a key like `lang` replaces
-- the whole sub-table):
--   return { profile = "server", extra = { picker = true, lang = { lua = true, shell = true, conf = true, text = false, python = true, go = false, rust = false, cpp = false, web = false, latex = false, lsp = false } } }

return "full"

