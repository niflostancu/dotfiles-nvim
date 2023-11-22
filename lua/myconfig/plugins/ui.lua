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
lvimPlugin({ "nvim-focus/focus.nvim",
  branch = 'master',
  config = function()
    require("focus").setup({
      ui = {
        signcolumn = false,
      }
    })
  end
})

-- disable Focus.nvim for specific file / buffer types
local ignore_filetypes = {
  'neo-tree', "NvimTree", "SidebarNvim", "Trouble", "terminal", "OverseerList",
  "fugitiveblame", "undotree", "dap-repl", "dapui_console", "dapui_watches",
  "dapui_stacks", "dapui_breakpoints", "dapui_scopes",
  "NeogitStatus", "NeogitLogView", "NeogitPopup", "NeogitCommitMessage",
}
local ignore_buftypes = {
  'nofile', 'prompt', 'popup', "toggleterm", "TelescopePrompt", "Trouble"
}
local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
    end
  end,
  desc = 'Disable focus autoresize for BufType',
})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function(_)
    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
      vim.b.focus_disable = true
    else
      vim.b.focus_disable = false
    end
  end,
  desc = 'Disable focus autoresize for FileType',
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
    local function tab_modified(tab, mod, not_mod)
      local wins = require("tabby.module.api").get_tab_wins(tab)
      for _, x in pairs(wins) do
        if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
          return mod end
      end return not_mod
    end
    local theme = {
      fill = 'TabLineFill', head = 'TabLineSel',
      current_tab = { bg = "#98c379", fg = "#000000" },
      tab = 'TabLine', inactive_tab = 'TabLine',
      win = 'TabLine', tail = 'TabLine',
    }
    local get_tab_name = function(tab)
      local name = tab.name()
      if not (name == nil or name == '') then return name end
      local ok, twd = pcall(vim.fn.getcwd, 0, tab.id)
      if not ok then return "<???>" end
      return vim.fn.fnamemodify(twd, ":t")
    end
    require('tabby.tabline').set(function(line)
      return {
        {
          { '  ', hl = theme.head },
          line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
          local num_hl = tab.is_current() and theme.fill or theme.current_tab
          local sep_l = line.sep('', hl, theme.fill)
          local sep_r = line.sep('', hl, theme.fill)
          if ((line.api.get_current_tab() - tab.number()) > 0) then sep_l = '' end
          if ((tab.number() - line.api.get_current_tab()) > 0) then sep_r = '' end
          return {
            sep_l, line.sep(' ', hl, hl),
            -- nf-md-numeric_<X>_circle for tab ID
            line.sep(vim.fn.nr2char(0xf0ca0 - 2 + 2 * tab.number()), num_hl, hl),
            line.sep(' ', hl, hl),
            get_tab_name(tab), tab_modified(tab.id, "󰐗 ", " "),
            sep_r, hl = hl, margin = '',
          }
        end),
        line.spacer(),
        hl = theme.fill,
      }
    end, {
        tab_name = {
          name_fallback = function() return '' end
        },
      }
    )
  end,
  dependencies = {
    {'nvim-lualine/lualine.nvim', lazy = true},
    {'nvim-tree/nvim-web-devicons', lazy = true}
  },
})

lvim.keys.normal_mode["<S-h>"] = "<Cmd>tabprevious<CR>"
lvim.keys.normal_mode["<S-l>"] = "<Cmd>tabnext<CR>"

--- Zen Mode plugin
lvimPlugin({ "folke/zen-mode.nvim",
  config = function()
    require("zen-mode").setup({
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = (not vim.g.neovide) },
      },
      on_open = function(win)
        vim.g.neovide_scale_factor_old = vim.g.neovide_scale_factor
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + vim.g.myconfig_zen_add_scale
      end,
      on_close = function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor_old
      end,
    })
  end
})
vim.g.myconfig_zen_add_scale = 0.2
lvim.keys.normal_mode["<S-z>"] = "<Cmd>ZenMode<CR>"

-- Noice.nvim: messages & cmdline replacement!
lvimPlugin({ "folke/noice.nvim",
  event = "VeryLazy",
  config = function()
    vim.lsp.handlers["textDocument/signatureHelp"] = require("noice.lsp.signature").on_signature
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = false, },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      views = {
        mini = {
          winblend = vim.g.mycfg_float_winblend,
          winhighlight = {},
        },
      },
      cmdline = { view = "cmdline", },
      messages = {
        view = "mini",
        view_warn = "mini",
        view_error = "mini",
      },
      notify = { view = "mini", },
      routes = {
        { filter = {
            any = { {
              event = { "msg_showmode", "msg_showcmd", "msg_ruler" }
            }, { event = "msg_show", kind = "search_count" } },
          },
          opts = { skip = true } },
      },
    })
    require("notify").setup({
      render = "compact",
      timeout = 5000,
      stages = "static",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  }
})

-- Improve vim.ui.* interface
lvimPlugin({
  'stevearc/dressing.nvim',
  opts = {},
})

