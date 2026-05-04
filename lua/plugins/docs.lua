--[[
  Development documentation / reference plugins.
]]

local prefix = "<Leader>f"

return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      if opts.treesitter.ensure_installed ~= "all" then
        opts.treesitter.ensure_installed = require("astrocore").list_insert_unique(
          opts.treesitter.ensure_installed, { "html" })
      end
    end,
  },

  -- TODO find alternatives
  -- {
  --   "luckasRanarison/nvim-devdocs",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   cmd = {
  --     "DevdocsFetch",
  --     "DevdocsInstall",
  --     "DevdocsUninstall",
  --     "DevdocsOpen",
  --     "DevdocsOpenFloat",
  --     "DevdocsUpdate",
  --     "DevdocsUpdateAll",
  --   },
  --   keys = {
  --     { prefix .. "d", "<Cmd>DevdocsOpenCurrentFloat<CR>", desc = "Find Devdocs for current file", mode = { "n" } },
  --     { prefix .. "D", "<Cmd>DevdocsOpenFloat<CR>", desc = "Find Devdocs", mode = { "n" } },
  --   },
  --   opts = {
  --     previewer_cmd = vim.fn.executable "glow" == 1 and "glow" or nil,
  --     cmd_args = { "-s", "dark", "-w", "80" },
  --     picker_cmd = true,
  --     picker_cmd_args = { "-p" },
  --     filetypes = {
  --       typescript = { "node", "javascript", "typescript" },
  --     },
  --   },
  -- },
}
