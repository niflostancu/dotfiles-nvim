--[[
  Text editing helper plugins + configurations.
]]

-- Neovim clipboard provider
lvimPlugin({
  "matveyt/neoclip",
  config = function ()
    
  end
})

-- clipboard history manager using Telescope
lvimPlugin({
  "AckslD/nvim-neoclip.lua",
  dependencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('neoclip').setup({
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<c-p>',
              paste_behind = '<c-k>',
              replay = '<c-q>', -- replay a macro
              delete = '<c-d>', -- delete an entry
              custom = {},
            },
            n = {
              select = '<cr>',
              paste = 'p',
              paste_behind = 'P',
              replay = 'q',
              delete = 'd',
              custom = {},
            }
          }
        }
      })
  end,
})

-- `s` motions (similar to Sneak / EasyMotion / Lightspeed)
lvimPlugin({ "ggandor/leap.nvim",
  config = function()
    require('leap').set_default_keymaps()
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

