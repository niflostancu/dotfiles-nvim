--[[
  Clipboard-related plugins & configuration.
]]

return {
  { "AckslD/nvim-neoclip.lua",
    event = { "User AstroFile", "InsertEnter" },
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>fy"] = { "<Cmd>Telescope neoclip<CR>", desc = "Find yanks (neoclip)" },
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("neoclip").setup(opts)
      require("telescope").load_extension "neoclip"
    end,
  },
  { "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        opt = {
          clipboard = "unnamed",
        }
      },
      mappings = {
        n = {
          -- Binding to yank all lines to clipboard
          ["<Leader>y"] = { '<Cmd>%y+<CR>', desc = "Yank all to +clipboard" },
        }
      },
      autocmds = {
        -- ShaDa auto-saving & reloading: share yank data between nvim instances
        ShadaYank = {
          {
            event = { "TextYankPost", "FocusLost" },
            callback = function() vim.cmd("wshada") end,
            desc = "Write shada on yank / unfocus"
          },
          {
            event = { "CursorHold", "FocusGained" },
            callback = function() vim.cmd("rshada") end,
            desc = "Reload shada on idle / focus"
          }
        }
      },
    },
  }
}
