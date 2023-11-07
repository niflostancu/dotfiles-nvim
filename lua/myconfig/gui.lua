--[[
  Vim GUI configs.
]]

-- default winblend options (for TUI)
vim.g.mycfg_float_winblend = 10
vim.o.winblend = 10

-- Neovide GUI specific configs
if vim.g.neovide then
  -- we can use a greater winblend values since NeoVide blurs
  vim.g.mycfg_float_winblend = 30
  vim.o.winblend = 20

  vim.o.guifont = "SauceCodePro_Nerd_Font:h14:#e-subpixelantialias:#h-full"

  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_scroll_animation_length = 0.15

  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.6
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 20.0
  vim.g.neovide_cursor_vfx_particle_speed = 10.0

  vim.g.neovide_floating_blur_amount_x = 5.0
  vim.g.neovide_floating_blur_amount_y = 5.0

  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
      change_scale_factor(1.25)
    end)
  vim.keymap.set("n", "<C-->", function()
      change_scale_factor(1/1.25)
    end)
end

-- Disable IME in everything except INPUT mode
local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end
local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
})
vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
})
