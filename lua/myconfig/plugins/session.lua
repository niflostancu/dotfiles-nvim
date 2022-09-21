--[[
  Vim session saving plugins / tweaks.
]]


vim.opt.sessionoptions = { "blank", "buffers", "help", "tabpages"}

lvimPlugin({
  'jedrzejboczar/possession.nvim',
  config = function ()
    local Path = require("plenary.path")
    require('possession').setup({
      session_dir = Path:new(vim.fn.getcwd()):absolute(),
      silent = false,
      load_silent = true,
      debug = false,
      prompt_no_cr = false,
      autosave = {
        current = false,
        tmp = false,
        tmp_name = 'tmp',
        on_load = false,
        on_quit = false,
      },
      commands = {
        save = 'SS',
        load = 'SL',
        delete = 'SDel',
        show = 'SSh',
        list = 'SList',
        migrate = 'SMigrate',
      },
      hooks = {
        before_save = function(name) return {} end,
        after_save = function(name, user_data, aborted) end,
        before_load = function(name, user_data)
          -- vim.o.winminheight = 0
          return user_data
        end,
        after_load = function(name, user_data) end,
      },
      plugins = {
        close_windows = false,
        delete_hidden_buffers = false,
        nvim_tree = true,
        tabby = true,
        delete_buffers = false,
      },
    })
  end,
  requires = { 'nvim-lua/plenary.nvim' },
})

