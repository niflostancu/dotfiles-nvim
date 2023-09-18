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
  version = false,
  config = function()
    require("focus").setup({
      ui = {
        signcolumn = false,
      }
    })
  end
})

-- disable Focus.nvim for specific file / buffer types
local ignore_filetypes = { 'neo-tree', "NvimTree" }
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
      vim.w.focus_disable = true
    else
      vim.w.focus_disable = false
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
        tmux = { enabled = true },
      }
    })
  end
})
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

