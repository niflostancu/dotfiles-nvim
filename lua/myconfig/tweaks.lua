--[[
  [Lunar]Vim personalized options / tweaks.
]]

-- please don't:
lvim.format_on_save = false

-- Standard vim options
vim.opt.fileformats = "unix,dos,mac"
vim.opt.clipboard = ""
vim.opt.cmdheight = 1
vim.opt.visualbell = true
vim.opt.virtualedit = "block"

-- Options for text editing 
vim.opt.textwidth =  80    -- Text width maximum chars before wrapping
vim.opt.expandtab = false  -- Don't expand tabs to spaces by default.
vim.opt.tabstop = 4        -- The number of spaces a tab is
vim.opt.shiftwidth = 4     -- Number of spaces to use in auto(indent)
vim.opt.softtabstop = 0    -- Don't use softtabstop
vim.opt.smarttab = true    -- Tab insert blanks according to 'shiftwidth'
vim.opt.autoindent = true  -- Use same indenting on new lines
vim.opt.smartindent = true -- Smart autoindenting on new lines
vim.opt.shiftround = true  -- Round indent to multiple of 'shiftwidth'
vim.opt.list = false       -- Keep whitespace characters hidden
vim.opt.listchars:append("eol:↴")

-- Editor Behavior options
vim.opt.wrap = false                -- No wrap by default
vim.opt.linebreak = true            -- Break long lines at 'breakat'
vim.opt.breakat = " \t;:,!?"        -- Long lines break chars
vim.opt.switchbuf = "useopen,usetab"  -- Switch to open buffer's window / tab
vim.opt.diffopt="filler,iwhite"  -- Diff mode: show fillers, ignore white
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"

require("lvim.core.autocmds").clear_augroup("_format_options")
vim.opt.formatoptions = {
    ["1"] = true,
    ["2"] = true, -- Use indent from 2nd line of a paragraph
    q = true,  -- continue comments with gq"
    c = true,  -- Auto-wrap comments using textwidth
    r = true,  -- Continue comments when pressing Enter
    n = true,  -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true,  -- remove a comment leader when joining lines.
    l = true,  -- Long lines are not broken in insert mode
}

-- open help in vert split
vim.api.nvim_create_autocmd("BufEnter", {
  group = myconfigroup, pattern="*.txt",
  command = "if &buftype == 'help' | wincmd L | endif"
})

-- Settings for lvim's core plugins 
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.lualine.extensions = { "nvim-tree" }
lvim.builtin.nvimtree.setup.diagnostics.enable = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.signcolumn = 'no'

-- autocmds to highlight the cursor line from the active window only
vim.api.nvim_create_autocmd("WinLeave", {
  group = myconfigroup, pattern = "*",
  callback = function() vim.wo.cursorline = false end,
})
vim.api.nvim_create_autocmd("WinEnter", {
  group = myconfigroup, pattern = "*",
  callback = function() vim.wo.cursorline = true end,
})

