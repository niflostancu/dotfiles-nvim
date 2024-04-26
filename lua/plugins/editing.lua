return {
  { "nvim-focus/focus.nvim",
  	opts = {
      ui = {
        signcolumn = false,
      }
    }
  },
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
      return opts
    end
  },
}

