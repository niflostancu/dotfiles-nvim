--[[
  Defines personalized key mappings (overriding LunarVim defaults).
]]

lvim.leader = "space"

-- Which key UI
lvim.builtin.which_key.setup.window.winblend = vim.g.mycfg_float_winblend
lvim.builtin.which_key.setup.window.border = "none"

vim.o.timeoutlen = 300

-- modify <leader>Lc to edit this `myconfig`
lvim.builtin.which_key.mappings["L"]["c"] = {
  "<cmd>edit " .. get_config_dir() .. "/lua/myconfig/init.lua<cr>",
  "Edit myconfig",
}

-- <leader>C to change tab directory to current file
lvim.builtin.which_key.mappings["C"] = {
  function()
    local file_dir = vim.fn.expand('%:h')
    vim.cmd("tcd" .. vim.fn.fnameescape(file_dir))
  end,
  "Change Dir to current file",
}

-- save with ctrl-s
lvim.keys.normal_mode["<C-s>"] = "<Cmd>w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<Cmd>w<CR>"
lvim.keys.visual_mode["<C-s>"] = "<Cmd>w<CR>"

-- use arrows for window movement, too
lvim.keys.normal_mode["<C-Up>"] = "<C-w>k"
lvim.keys.normal_mode["<C-Down>"] = "<C-w>j"
lvim.keys.normal_mode["<C-Left>"] = "<C-w>h"
lvim.keys.normal_mode["<C-Right>"] = "<C-w>l"

-- remove J / K override in visual mode
lvim.keys.visual_block_mode["J"] = false
lvim.keys.visual_block_mode["K"] = false

-- nvimtree / telescope / other finder bindings with ';'
lvim.keys.normal_mode["<F3>"] = "<Cmd>NvimTreeToggle<CR>"

-- Yank all lines to clipboard
lvim.builtin.which_key.mappings["y"] = {
  '<Cmd>%y+<CR>', "Yank all to +clipboard",
}
-- enable some useful presets
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.plugins.presets.windows = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.z = true
lvim.builtin.which_key.setup.plugins.presets.g = true

-- register custom, top-level which_key mappings
-- format: { [mappings], [opts] }
myconfig.which_key = {}
lvim.builtin.which_key.on_config_done = function()
  local which_key = require("which-key")
  for _, my_which_keys in pairs(myconfig.which_key) do
    which_key.register(my_which_keys.mappings, my_which_keys.opts)
  end
end

-- autocommand to record tab on change + bindings to switch to the previous tab
vim.api.nvim_create_autocmd("TabLeave", {
  group = myconfigroup, pattern = "*",
  callback = function() vim.g.lasttab = vim.fn.tabpagenr() end,
})
lvim.builtin.which_key.mappings['t'] = {
  function() vim.cmd("tabn " .. (vim.g.lasttab or 1)) end,
  "Switch to last tab"
}

lvim.keys.normal_mode['<C-q>'] = function()
  require("myconfig.utils.nvr").capture_mode()
end

-- go to tab by number
for i = 1, 9 do
  lvim.keys.normal_mode["g" .. i] = function()
    if i <= vim.fn.tabpagenr('$') then
      vim.cmd("tabn " .. i)
    end
  end
end

