--[[
  User interface plugins.
]]

-- tmux integration
lvimPlugin({ "aserowy/tmux.nvim",
  config = function()
    require("tmux").setup({
      copy_sync = {
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
    })
  end
})

-- add indentation guidelines (using nvim's virtual text feature)
-- note: indent-blankline is now bundled with LunarVim
lvim.builtin.indentlines.options = {
  show_current_context = true,
  show_current_context_start = true,
}

--- auto-resize focused splits for nvim based on golden ratio
lvimPlugin({ "beauwilliams/focus.nvim", 
  config = function()
    require("focus").setup({
      signcolumn = false,
      -- excluded_buftypes = {"help"},
      excluded_filetypes = {"toggleterm", "TelescopePrompt", "Trouble"}
    })
  end
})

-- disable builtin bufferline plugin (prefer tabs)
lvim.builtin.bufferline.active = false
-- lvim.builtin.bufferline.options.mode = 'tabs'
-- lvim.builtin.bufferline.options.custom_filter = nil
-- lvim.builtin.bufferline.options.themable = true
-- lvim.builtin.bufferline.options.offsets = {}

-- add Tabby
lvimPlugin({
  "nanozuki/tabby.nvim",
  config = function()
    local tabhl = { bg = "#98c379", fg = "#000000" }
    require('tabby.tabline').use_preset('tab_only', {
      theme = {
        fill = 'TabLineFill',
        head = 'TabLine',
        current_tab = tabhl,
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
    })
  end,
  dependencies = {
    {'nvim-lualine/lualine.nvim', opt = true},
    {'nvim-tree/nvim-web-devicons', opt = true}
  },
  after = "lualine.nvim",
})

lvim.keys.normal_mode["<S-h>"] = "<Cmd>tabprevious<CR>"
lvim.keys.normal_mode["<S-l>"] = "<Cmd>tabnext<CR>"

--- Zen Mode plugin
lvimPlugin({ "folke/zen-mode.nvim", 
  config = function()
    require("zen-mode").setup({
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = true },
      }
    })
  end
})

