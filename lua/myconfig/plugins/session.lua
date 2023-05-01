--[[
  Vim session saving plugins / tweaks.
]]


vim.opt.sessionoptions = { "blank", "buffers", "help", "tabpages"}

local defaultPossessionName = '.session'

lvimPlugin({
  'jedrzejboczar/possession.nvim',
  config = function ()
    local Path = require("plenary.path")
    local session_dir = Path:new(vim.fn.getcwd()):absolute()
    require('possession').setup({
      session_dir = session_dir,
      silent = false,
      load_silent = true,
      debug = false,
      prompt_no_cr = false,
      autosave = {
        current = true,
        tmp = false,
        tmp_name = 'tmp',
        on_load = false,
        on_quit = true,
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
        delete_hidden_buffers = true,
        nvim_tree = true,
        tabby = true,
        delete_buffers = false,
      },
    })
  end,
  dependencies = { 'nvim-lua/plenary.nvim' },
})

-- add Alpha dashboard command

table.insert(lvim.builtin.alpha.dashboard.section.buttons.entries, 0,
  { "s", lvim.icons.ui.Project .. "  Load Session", "<CMD>SL<CR>" }
)

-- Restore previous session on load
local in_pager_mode = true -- automatic loading disabled
local shouldAutoLoadSession = function()
  local opened_with_args = next(vim.fn.argv()) ~= nil
  local is_headless = not vim.tbl_contains(vim.v.argv, '--embed') and not next(vim.api.nvim_list_uis())
  return not (opened_with_args or in_pager_mode or is_headless)
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = myconfigroup, pattern = "*",
  callback = function()
    local sessPath = require('possession.paths').session(defaultPossessionName)
    if sessPath:exists() and shouldAutoLoadSession() then
      require('possession.commands').load(defaultPossessionName)
    end
  end,
})
vim.api.nvim_create_autocmd("StdinReadPre", {
  group = myconfigroup, pattern = "*",
  callback = function() in_pager_mode = true end,
})
