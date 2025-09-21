return {
  {
    "nosduco/remote-sshfs.nvim",
    opts = {
      connections = {
        sshfs_args = { -- arguments to pass to the sshfs command
          "-o reconnect",
          "-o ConnectTimeout=5",
        },
      },
      mounts = {
        base_dir = vim.fn.expand("$HOME" .. "/.cache/nvim-sshfs/"),
        unmount_on_exit = true,
      },
    },
    dependencies = {
      "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim",
      {
        -- add key bindings using astrocore
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local mappings = opts.mappings
          local api = require('remote-sshfs.api')

          mappings.n["<Leader>r"] = { desc = "Remote Connect" }
          mappings.n["<Leader>rc"] = { api.connect, desc = "[R/SSHFS] Connect" }
          mappings.n["<Leader>rd"] = { api.disconnect, desc = "[R/SSHFS] Disconnect" }
          mappings.n["<Leader>re"] = { api.edit, desc = "[R/SSHFS] Edit" }

          -- override telescope find_files and live_grep to act based on whether connected to ssh
          local builtin = require("telescope.builtin")
          local connections = require("remote-sshfs.connections")
          local check_pwd_conn = function()
            if not connections.is_connected() then return false end
            local pwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
            local mountp = vim.fn.fnamemodify(connections.get_current_mount_point(), ":p")
            -- http://lua-users.org/wiki/StringRecipes
            return pwd:sub(1, #mountp) == mountp
          end

          mappings.n[";f"] = {
            function()
              if check_pwd_conn() then
                api.find_files()
              else
                builtin.find_files()
              end
            end,
            desc = "[Telescope] Find File"
          }
          mappings.n[";g"] = {
            function()
              if check_pwd_conn() then
                api.live_grep()
              else
                builtin.live_grep()
              end
            end,
            desc = "[Telescope] Grep Files"
          }
        end
      },
    },
  },
}

