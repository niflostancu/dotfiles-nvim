--[[
  Editing support plugins.
]]

return {
  -- Dynamically resize focused windows (golden radio-like)
  { "nvim-focus/focus.nvim",
  	opts = {
      ui = {
        signcolumn = false,
      }
    }
  },
  -- Astrocore customizations for focus.nvim exclusions
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local ignore_buftypes = {
        'prompt', 'popup', "toggleterm", "TelescopePrompt", "Trouble"
      }
      local ignore_filetypes = {
        'neo-tree', "NvimTree", "SidebarNvim", "Trouble", "terminal", "OverseerList",
        "fugitiveblame", "undotree", "dap-repl", "dapui_console", "dapui_watches",
        "dapui_stacks", "dapui_breakpoints", "dapui_scopes",
      }
      opts.autocmds.focus_nvim_ignore = {
        {
          event = "WinEnter",
          desc = "Disable focus.nvim autoresize for specific buftypes",
          callback = function()
            if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
              vim.w.focus_disable = true
            else
              vim.w.focus_disable = false
            end
          end,
        },
        {
          event = "FileType",
          desc = "Disable focus.nvim autoresize for specific filetypes",
          callback = function()
            if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
              vim.b.focus_disable = true
            else
              vim.b.focus_disable = false
            end
          end,
        },
      };
      opts.mappings.n["Z"] = { "<Cmd>ZenMode<CR>", desc = "Zen Mode" }
    end
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = function() return math.min(120, vim.o.columns * 0.75) end,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          foldcolumn = "0",
          list = false,
          showbreak = "NONE",
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          cmdheight = 1,
          laststatus = 0,
        },
      },
    },
  }
}

