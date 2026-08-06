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

  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n[";p"] = {
        function()
          for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
            local buffer_name = vim.api.nvim_buf_get_name(buffer)
            if (string.sub(buffer_name, 1, 7) == "term://") then
              vim.cmd('vsplit')
              vim.api.nvim_win_set_buf(0, buffer)
              return
            end
          end
          vim.api.nvim_command(":vert terminal")
        end,
        desc = "[Terminal] Toggle Side Term"
      }
    end,
  }
}
