--[[
  Picker (fuzzy finder) plugins & mappings.
]]

return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      -- Fuzzy finder/picker
      picker = {
        ---@class snacks.picker.matcher.Config
        matcher = {
          smartcase = true, ignorecase = true,
          filename_bonus = true, -- bonus for matching file names (last part of the path)
          cwd_bonus = true, -- give bonus for matching files in the cwd
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
        -- replace `vim.ui.select` with the snacks picker
        ui_select = true,
      },
      -- vim.ui.input replacement
      input = {
      }
    }
  },
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
        auto_expand_width = false,
        mappings = {
          ["/"] = "noop",  -- disable the default mapping
        },
      })
    end,
    config = function(_, opts)
      require("neo-tree").setup(opts)
      -- Add a custom keymap for normal mode search in Neo-tree buffer
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/791#issuecomment-2240768050
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neo-tree",
        callback = function() vim.api.nvim_buf_set_keymap(0, "n", "/", "/", { noremap = true, silent = true }) end,
      })
    end,
  },
  -- adjust key mappings
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n[";"] = {
        desc = "[Find]"
      }
      maps.n[";b"] = {
        function() Snacks.picker.buffers({
          hidden = false,
          unloaded = true,
          current = false,
          sort_lastused = true,
          filter = { cwd = true, },
        }) end,
        desc = "[Picker] Buffers (cwd)"
      }
      maps.n[";B"] = {
        function() Snacks.picker.buffers() end,
        desc = "[Picker] Buffers (all)"
      }
      maps.n[";e"] = {
        function()
          local bufpath = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
          require("myconfig.utils.nvr").remote_open(bufpath)
        end,
        desc = "[NVR] Remote Open"
      }
      maps.n[";f"] = {
        function()
          Snacks.picker.files {
            hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
          }
        end,
        desc = "[Picker] Find Files (filtered)"
      }
      maps.n[";F"] = {
        function() Snacks.picker.files { hidden = true, ignored = true } end,
        desc = "[Picker] Find All Files"
      }
      maps.n[";g"] = {
        function() Snacks.picker.grep() end,
        desc = "[Picker] Grep Files"
      }
      maps.n[";G"] = {
        function() Snacks.picker.grep { hidden = true, ignored = true } end,
        desc = "[Picker] Grep All Files"
      }
      maps.n[";r"] = {
        function() Snacks.picker.resume() end,
        desc = "[Snakcs] Resume previous find"
      }
      maps.n[";;"] = {
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = "[LSP] Workspace Symbols"
      }
      maps.v = maps.v or {}
      maps.v[";g"] = {
        function()
          local text = require('myconfig.utils').get_visual_selection()
          Snacks.picker.grep({ cmd = text })
        end,
        desc = "[Picker] Grep Selection"
      }
      maps.c = maps.c or {}
      maps.c['<C-t>'] = {
        function() Snacks.picker.command_history() end,
        desc = "[Picker] Search Command History"
      }
    end
  },
}
