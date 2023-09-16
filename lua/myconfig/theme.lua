--[[
  Vim theme configuration.
]]

vim.o.background = "dark"

lvimPlugin({ "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function ()
    require('onedarkpro').setup({
      highlight_inactive_windows = true,
      transparency = true,
      highlights = {
        -- Comment = {
        --   fg = { onedark = "${yellow}", onelight = "${my_new_red}" }
        -- }
      }
    })
  end
})
lvim.colorscheme = "onedark"

vim.api.nvim_set_hl(0, "StatusLine", { fg = "#6CC644", bg = "NONE" })

-- Lualine customizations
local components = require("lvim.core.lualine.components")
local conditions = require("lvim.core.lualine.conditions")

lvim.builtin.lualine.style = 'lvim'
lvim.builtin.lualine.sections.lualine_a = { components.mode }
lvim.builtin.lualine.sections.lualine_b = {
  components.branch,
}
lvim.builtin.lualine.sections.lualine_c = {
  {
    "filename",
    file_status = true,
    color = {},
    cond = nil,
    path = 1,
    symbols = {
      modified = '[+]',      -- Text to show when the file is modified.
      readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]', -- Text to show for unnamed buffers.
    }
  },
}
local noice = require("noice")
lvim.builtin.lualine.sections.lualine_x = {
  { noice.api.status.mode.get, cond = noice.api.status.mode.has,
    color = { fg = "7edd44" } },
  components.diff,
  components.python_env,
  components.diagnostics,
  components.treesitter,
  components.lsp,
  components.filetype,
}
lvim.builtin.lualine.sections.lualine_y = {
  {
    function()
      if not vim.api.nvim_buf_get_option(0, "expandtab") then
        return "Tab: " .. vim.api.nvim_buf_get_option(0, "tabstop") .. " "
      end
      local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
      if size == 0 then
        size = vim.api.nvim_buf_get_option(0, "tabstop")
      end
      return "Space: " .. size .. " "
    end,
    cond = conditions.hide_in_width,
    color = {},
  }
}
lvim.builtin.lualine.sections.lualine_z = { "location", "progress", components.scrollbar }

-- workaround for setting lualine theme
lvim.builtin.lualine.on_config_done = function()
  require('lualine').setup({
    options = { theme = 'onedark' }
  })
end

