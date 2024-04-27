-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        -- Standard vim options
        fileformats = "unix,dos,mac",
        cmdheight = 1,
        ruler = false,
        visualbell = true,
        virtualedit = "block",
        -- Line numbering options
        number = true,          -- print line number in front of each line
        relativenumber = true,  -- show line numbers relative to current line
        -- Options for text editing 
        textwidth = 80,         -- Text width maximum chars before wrapping
        expandtab = false,      -- Don't expand tabs to spaces by default.
        tabstop = 4,            -- The number of spaces a tab is
        shiftwidth = 4,         -- Number of spaces to use in auto(indent)
        softtabstop = 0,        -- Don't use softtabstop
        smarttab = true,        -- Tab insert blanks according to 'shiftwidth'
        autoindent = true,      -- Use same indenting on new lines
        smartindent = true,     -- Smart autoindenting on new lines
        shiftround = true,      -- Round indent to multiple of 'shiftwidth'
        list = false,           -- Keep whitespace characters hidden
        -- listchars:append("eol:↴")

        -- Editor Behavior options
        wrap = false,                 -- No wrap by default
        linebreak = true,             -- Break long lines at 'breakat'
        breakat = " \t;:,!?",         -- Long lines break chars
        switchbuf = "useopen,usetab", -- Switch to open buffer's window / tab
        diffopt="filler,iwhite",      -- Diff mode: show fillers, ignore white
        spell = false,                -- disable spell checking
        hlsearch = true,              -- highlight all search terms
        signcolumn = "yes",           -- always show the sign column
        formatoptions = {
          ["1"] = true,
          ["2"] = true, -- Use indent from 2nd line of a paragraph
          q = true,  -- continue comments with gq"
          c = true,  -- Auto-wrap comments using textwidth
          r = true,  -- Continue comments when pressing Enter
          n = true,  -- Recognize numbered lists
          t = false, -- autowrap lines using text width value
          j = true,  -- remove a comment leader when joining lines.
          l = true,  -- Long lines are not broken in insert mode
        },
      },
      g = { -- vim.g.<key>

      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        ["<Leader>n"] = { '<Cmd>:nohlsearch<CR>', desc = "Un-highlight search" },

        -- quick save
        ["<C-s>"] = { "<Cmd>w<CR>", desc = "Save File" },
      },
      i = {
        ["<C-s>"] = { "<Cmd>w<CR>", desc = "Save File" },
      },
      v = {
        ["<C-s>"] = { "<Cmd>w<CR>", desc = "Save File" },

        -- Keep visual mode on indenting with '<', '>'
        ['<'] = { "<gv", desc = "Dec. Indent", noremap = true },
        ['>'] = { ">gv", desc = "Inc. Indent", noremap = true },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
    on_keys = {
      -- re-enable persistent hlsearch
      auto_hlsearch = false,
    },
  },
}
