--[[
  Machine profiles: named feature sets + hostname mapping.

  A profile is a flat set of feature flags (+ a `lang` sub-table).
  Plugin files gate themselves with `require("myconfig.profile").has(feature)`,
  e.g. `enabled = P.has("tmux")` or `if not P.has("lang.go") then return {} end`.

  The active profile is resolved in `myconfig/profile.lua`, which reads this
  file generically: profile entries are keyed by name; reserved keys with a
  `_` prefix (like `_hostnames`) are metadata, not profiles.
]]

local profiles = {
  -- hostname -> profile overrides (fill in as needed)
  _hostnames = {
    -- ["niflo-devbox"] = "full",
    -- ["arm-laptop"]   = "light",
    -- ["build-server"] = "server",
  },
  -- full dev workstation
  full = {
    tmux = true,
    clipboard = true,   -- neoclip + yank/shada config
    picker = true,      -- snacks picker + neo-tree explorer
    git = true,         -- neogit, gitsigns, fugitive, gh.nvim
    sshfs = true,       -- remote-sshfs
    ai = true,          -- codecompanion + MCP
    session = true,     -- resession, hbac, early-retirement
    gui = true,         -- winblend, neovide, dashboard
    lang = {
      lsp = true,       -- astrolsp engine
      lua = true, shell = true, conf = true, text = true,
      python = true, go = true, rust = true,
      cpp = true, web = true, latex = true,
    },
  },
  -- lightweight machine (e.g. ARM laptop)
  light = {
    tmux = true,
    clipboard = true,
    picker = true,
    git = true,
    sshfs = true,
    ai = false,
    session = true,
    gui = true,
    lang = {
      lsp = true,
      lua = true, shell = true, conf = true, text = true,
      python = true, go = true, rust = true,
      cpp = false, web = false, latex = false,
    },
  },
  -- server: minimal subset
  server = {
    tmux = true,
    clipboard = false,
    picker = false,
    git = true,
    sshfs = false,
    ai = false,
    session = false,
    gui = false,
    lang = {
      lsp = false,
      lua = true, shell = true, conf = true, text = false,
      python = false, go = false, rust = false,
      cpp = false, web = false, latex = false,
    },
  },
}

return profiles
