--[[
  Text / file / code finder plugins & tools.
]]

-- builtin Telescope customization

local telescope_cfg = {
  defaults = {
    theme = "ivy",
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 25,
    },
    path_display = { truncate = 3 },
    dynamic_preview_title = true,
    border = true,
    borderchars = {
      prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      results = { " " },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  },
}
lvim.builtin.telescope.pickers = { buffers = {} }

local ok, actions = pcall(require, "telescope.actions")
if ok then
  local action_state = require("telescope.actions.state")
  local myactions = {}
  myactions.open_in_nvr = function()
    -- local current_picker = action_state.get_current_picker(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    require("myconfig.utils.nvr").remote_open(entry.path)
  end

  telescope_cfg.defaults.mappings = {
    n = {
      ["<C-c>"] = actions.close,
      ["<C-e>"] = myactions.open_in_nvr,
    },
    i = {
      ["jj"] = { "<esc>jj", type = "command" },
      ["<C-c>"] = actions.close,
      ["<C-e>"] = myactions.open_in_nvr,
    },
  }
  lvim.builtin.telescope.pickers.buffers.mappings = {
    n = { ["dd"] = actions.delete_buffer },
    i = { ["C-d"] = actions.delete_buffer }
  }
end
lvim.builtin.telescope = vim.tbl_deep_extend("force",
  lvim.builtin.telescope, telescope_cfg)

-- advanced telescope config (load third party extensions)
lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension "neoclip"
  telescope.load_extension "frecency"
end

-- Telescope buffers + MRU files as buffers replacement
lvimPlugin({
  "nvim-telescope/telescope-frecency.nvim",
  dependencies = {"tami5/sqlite.lua"}
})

-- register a new top-level mappings with find-related commands
myconfig.which_key.find = {
  mappings = {},
  opts = { mode = 'n', prefix = ';', noremap = true, nowait = true,
    silent = true }
}
myconfig.which_key.find_visual = {
  mappings = {},
  opts = { mode = 'v', prefix = ';', noremap = true, nowait = true,
    silent = true }
}
-- note: more mappings are defined by [[code_diag.lua]]
myconfig.which_key.find.mappings = {
  name = "[find]",
  ["a"] = {
    function()
      local api = require('nvim-tree.api')
      api.tree.find_file({
        path = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
        focus = true, open = true
      })
    end,
    "[NvimTree] Find current file"
  },
  ["b"] = {
    -- function() require('telescope').extensions.frecency.frecency()
    function() require('telescope.builtin').buffers({
      only_cwd = true,
      sort_mru = true,
      sort_lastused = true,
      previewer = false,
    }) end,
    "[Telescope] Buffers (cwd)"
  },
  ["B"] = {
    function() require('telescope.builtin').buffers({
      sort_mru = true,
      sort_lastused = true,
      previewer = false,
    }) end,
    "[Telescope] Buffers (all)"
  },
  ["e"] = {
    function()
      local bufpath = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      require("myconfig.utils.nvr").remote_open(bufpath)
    end,
    "[Telescope] Find File"
  },
  ["f"] = {
    function() require('telescope.builtin').find_files() end,
    "[Telescope] Find File"
  },
  ["F"] = {
    "<cmd>Telescope oldfiles<cr>", "[Telescope] Old Files"
  },
  ["g"] = {
    "<cmd>Telescope live_grep<cr>", "[Telescope] Grep Files"
  },
  ["G"] = {
    function() require('telescope.builtin').live_grep({grep_open_files=true}) end,
    "[Telescope] Grep Files"
  },
  ["r"] = {
    "<Cmd>Telescope resume<CR>", "[Telescope] Resume previous find"
  },
  [";"] = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "[LSP] Workspace Symbols"
  },
}

myconfig.which_key.find_visual.mappings = {
  name = "[find-v]",
  ["g"] = {
    function()
      local text = require('myconfig.utils.selection').get_visual_selection()
      require('telescope.builtin').grep_string { default_text = text }
    end,
    "[Telescope] Grep Selection"
  },
}

-- Map Telescope's command_history as Ctrl+T in Command mode
vim.api.nvim_set_keymap('c', '<C-t>',
  [[<Cmd>lua require('telescope.builtin').command_history()<CR>]], {})

-- Spectre Find & Replace plugin
lvimPlugin({
  "nvim-pack/nvim-spectre",
  event = "BufRead",
  config = function()
    require("spectre").setup()
  end,
})
myconfig.which_key.find.mappings['S'] = {
  "<cmd>lua require('spectre').open()<CR>",
  "[Spectre] Find & Replace"
}

