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
lvimPlugin({ "lukas-reineke/indent-blankline.nvim", 
  config = function() 
    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = true,
    }
  end
})

--- auto-resize focused splits for nvim based on golden ratio
lvimPlugin({ "beauwilliams/focus.nvim", 
  config = function()
    require("focus").setup({
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
    local util = require('tabby.util')
    local hl_tabline_fill = util.extract_nvim_hl('lualine_c_normal') -- 背景
    local hl_tabline = util.extract_nvim_hl('lualine_b_normal')
    local hl_tabline_sel = util.extract_nvim_hl('lualine_a_normal') -- 高亮

    local function tab_label(tabid, active)
      local icon = active and '' or ''
      local number = vim.api.nvim_tabpage_get_number(tabid)
      local name = util.get_tab_name(tabid)
      return string.format('%d: %s ', number, name)
    end

    local preset = {
      hl = 'TabLineFill',
      layout = 'tab_only',
      head = {
        { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
        { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
      },
      active_tab = {
        label = function(tabid)
          return {
            tab_label(tabid, true),
            hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
          }
        end,
        left_sep = { ' ', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
      },
      inactive_tab = {
        label = function(tabid)
          return {
            tab_label(tabid, false),
            hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'bold' },
          }
        end,
        left_sep = { ' ', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
      },
    }
    require('tabby').setup {
      tabline = preset,
    }
  end,
  requires = {
    {'nvim-lualine/lualine.nvim', opt = true},
    {'kyazdani42/nvim-web-devicons', opt = true}
  },
  after = "lualine.nvim",
})

lvim.keys.normal_mode["<S-h>"] = "<Cmd>tabprevious<CR>"
lvim.keys.normal_mode["<S-l>"] = "<Cmd>tabnext<CR>"

