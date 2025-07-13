--[[
  Finder plugins & mappings.
]]

return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").load_extension("ui-select")
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      theme = "dropdown",
      defaults = {
        -- winblend = vim.g.mycfg_float_winblend + 10,
        sorting_strategy = "ascending",
        -- layout_strategy = "bottom_pane",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom",
            preview_width = 0.55,
            results_width = 0.6,
          },
          vertical = {
            mirror = false,
          },
          width = 0.75,
          height = 0.70,
          preview_cutoff = 100,
        },
        path_display = { truncate = 3 },
        dynamic_preview_title = true,
        -- use flat border
        borderchars = {" ", " ", " ", " ", " ", " ", " ", " "},
        -- ripgrep args
        vimgrep_arguments = {
          "rg", "--color=never", "--no-require-git",
          "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case"
        }
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }
      }
    }
  },
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
  {
    "nvim-pack/nvim-spectre",
    opts = {
      open_cmd = 'vnew',
    },
    config = true
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n[";"] = {
        desc = "[Find]"
      }
      maps.n[";b"] = {
        function() require('telescope.builtin').buffers({
          only_cwd = true,
          sort_mru = true,
          show_all_buffers = false,
          sort_lastused = true,
          ignore_current_buffer = true,
          previewer = false,
        }) end,
        desc = "[Telescope] Buffers (cwd)"
      }
      maps.n[";B"] = {
        function() require('telescope').extensions.hbac.buffers({
          sort_mru = true,
          sort_lastused = true,
          previewer = false,
        }) end,
        desc = "[Telescope] Buffers (all)"
      }
      maps.n[";e"] = {
        function()
          local bufpath = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
          require("myconfig.utils.nvr").remote_open(bufpath)
        end,
        desc = "[NVR] Remote Open"
      }
      maps.n[";f"] = {
        function() require('telescope.builtin').find_files() end,
        desc = "[Telescope] Find File"
      }
      maps.n[";f"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
      maps.n[";F"] = {
        "<cmd>Telescope oldfiles<cr>", desc = "[Telescope] Old Files"
      }
      maps.n[";g"] = {
        "<cmd>Telescope live_grep<cr>", desc = "[Telescope] Grep Files"
      }
      maps.n[";G"] = {
        function() require('telescope.builtin').live_grep({grep_open_files=true}) end,
        desc = "[Telescope] Grep Files"
      }
      maps.n[";r"] = {
        "<Cmd>Telescope resume<CR>", desc = "[Telescope] Resume previous find"
      }
      maps.n[";;"] = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "[LSP] Workspace Symbols"
      }
      maps.v = maps.v or {}
      maps.v[";g"] = {
        function()
          local text = require('myconfig.utils').get_visual_selection()
          require('telescope.builtin').grep_string { default_text = text }
        end,
        desc = "[Telescope] Grep Selection"
      }
      maps.c = maps.c or {}
      maps.c['<C-t>'] = {
        [[<Cmd>lua require('telescope.builtin').command_history()<CR>]],
        desc = "[Telescope] Search Command History"
      }

    end
  }
}
