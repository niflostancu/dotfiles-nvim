--[[
  Text editing helper plugins + configurations.
]]

-- LunarVim's BigFile configuration
lvim.builtin.bigfile.config = {
  filesize = 2, -- MiB
  pattern = { "*" },
  features = { -- features to disable
    "indent_blankline", "illuminate", "lsp", "treesitter", "vimopts",
  },
}

-- `s` motions (similar to Sneak / EasyMotion / Lightspeed)
lvimPlugin({ "ggandor/leap.nvim",
  config = function()
    local leap = require('leap')
    leap.opts.highlight_unlabeled_phase_one_targets = true
    leap.opts.safe_labels = {}
    leap.set_default_keymaps()
  end,
  dependencies = { { "tpope/vim-repeat" } },
})

-- Highlight plugin for '/' text search
lvimPlugin({
  "kevinhwang91/nvim-hlslens",
  config = function()
    require('hlslens').setup({})
    local kopts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', 'n',
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', 'N',
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      kopts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    vim.api.nvim_set_keymap('n', '<Leader>n', ':noh<CR>', kopts)
  end
})

-- Sentiment - enhanced match parenthesis
lvimPlugin({
  "utilyre/sentiment.nvim", version = "*",
  event = "VeryLazy",
  opts = {},
  init = function()
    vim.g.loaded_matchparen = 1
  end,
})

-- Scrollbar with diagnostics / search hints
lvimPlugin({
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup({
      show_in_active_only = true,
      excluded_buftypes = {"help", "nofile"},
      excluded_filetypes = {"toggleterm", "prompt", "TelescopePrompt"}
    })
    require("scrollbar.handlers.search").setup()
  end,
  dependencies = { "kevinhwang91/nvim-hlslens" }
})

-- Sleuth - automatic indentation detection
lvimPlugin({ "tpope/vim-sleuth" })

-- EditorConfig integration
-- lvimPlugin({ "gpanders/editorconfig.nvim" })

-- Guess indent (auto disabled)
lvimPlugin({ "NMAC427/guess-indent.nvim",
  config = function() require('guess-indent').setup { auto_cmd = false } end,
})

