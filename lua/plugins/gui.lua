--[[
  GUI customizations (Neovide).
]]

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

local neovide_font = "SauceCodePro_NFM:h15:#e-subpixelantialias:#h-full"

local cfg_winblend = 10
if vim.g.neovide then
  cfg_winblend = 30
end

return {
  { "AstroNvim/astrocore",
    opts = function(_, opts)
      local opt = opts.options.opt
      local mappings = opts.mappings
      local go = opts.options.g

      -- setup winblend for transparency
      opt.winblend = cfg_winblend
      opt.pumblend = cfg_winblend

      -- Neovide GUI specific configs
      if vim.g.neovide then
        opt.guifont = neovide_font

        go.neovide_refresh_rate = 60
        go.neovide_refresh_rate_idle = 5
        go.neovide_scroll_animation_length = 0.15
        go.neovide_text_gamma = 0.8
        go.neovide_text_contrast = 0.2

        go.neovide_cursor_animation_length = 0.05
        go.neovide_cursor_trail_size = 0.6
        go.neovide_cursor_antialiasing = true
        go.neovide_cursor_vfx_mode = "pixiedust"
        go.neovide_cursor_vfx_particle_density = 20.0
        go.neovide_cursor_vfx_particle_speed = 10.0

        go.neovide_floating_blur_amount_x = 5.0
        go.neovide_floating_blur_amount_y = 5.0
        go.neovide_scale_factor = 1.0

        mappings.n["<C-=>"] = { function() change_scale_factor(1.1) end,
          desc = "[Neovide] Inc. Scaling" }
        mappings.n["<C-->"] = { function() change_scale_factor(1/1.1) end,
          desc = "[Neovide] Dec. Scaling" }
      end
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function (_, opts)
      if vim.g.neovide then
        -- workaround: neovide renders two stacked floating windows,
        -- so further increase transparency (additively applied to both of them)
        opts.defaults.winblend = cfg_winblend + 10
      else
        opts.defaults.winblend = cfg_winblend
      end
    end
  },
  {
    "folke/which-key.nvim",
    opts = function (_, opts)
      opts.win = opts.win or {}
      opts.win.winblend = cfg_winblend
    end
  },
}
