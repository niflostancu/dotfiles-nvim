-- Terminal integration plugins

return {
  { "aserowy/tmux.nvim",
    -- actually, AstroNVim bundles mrjones2014/smart-splits.nvim, so disabled
    -- for now
    enabled = false,
    opts = {
      copy_sync = {
        -- using separate plugin for terminal OSC52 integration
        enable = false,
        sync_clipboard = false,
      },
      navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,
      },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,
      }
    }
  },
}
