--[[
  Finder plugins & mappings.
]]

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
      },
      window = {
        mappings = {
          H = false, -- preferred for tab cycling
          z = false, -- prefer default: re-center window
          [">"] = "toggle_hidden",
          ["."] = function(state)
            -- make "." (set_root) always use tcd (by reimplementing it)
            local fs = require("neo-tree.sources.filesystem")
            if state.search_pattern then
              fs.reset_search(state, false)
            end
            local node = state.tree:get_node()
            if not node then
              return
            end
            local basedir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
            vim.cmd("tcd " .. basedir)
          end,
          ["<C-f>"] = {
            function (state)
              require("myconfig.neotreeutils").launch_find_files(state, {})
            end, desc = "[Picker] Find at current node"
          },
          ["<C-g>"] = {
            function (state)
              require("myconfig.neotreeutils").launch_live_grep(state, {})
            end, desc = "[Picker] Live grep at current node"
          }
        },
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<F3>"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" }
          maps.n[";a"] = { function()
            local reveal_file = vim.fn.expand('%:p')
            if reveal_file == '' then
              reveal_file = vim.fn.getcwd()
            else
              local f = io.open(reveal_file, "r")
              if f then
                f.close(f)
              else
                reveal_file = vim.fn.getcwd()
              end
            end
            require('neo-tree.command').execute({
              action = "focus",          -- OPTIONAL, this is the default value
              source = "filesystem",     -- OPTIONAL, this is the default value
              position = "left",         -- OPTIONAL, this is the default value
              reveal_file = reveal_file, -- path to file or folder to reveal
              reveal_force_cwd = true,   -- change cwd without asking if needed
            })
          end, desc = "Show in Explorer" }
        end
      },
    },
  },
}
