return {
  { import = "astrocommunity.pack.markdown" },
  {
    "nblock/vim-dokuwiki",
    setup = function()
      vim.filetype.add {
        extension = {
          foo = "fooscript",
        },
        filename = {
          ["Foofile"] = "fooscript",
        },
        pattern = {
          ["~/%.config/foo/.*"] = "fooscript",
        },
      }
    end
  },
  { "AstroNvim/astrocore",
    opts = {
      filetypes = {
        -- see `:h vim.filetype.add` for usage
        extension = {
          wiki = "dokuwiki",
          doku = "dokuwiki",
        },
      },
      autocmds = {
        text_ft_options = {
          {
            event = { "FileType" },
            pattern = { "dokuwiki" },
            desc = "Enable wrapping on wiki files",
            callback = function()
              vim.o.textwidth=0
              vim.o.wrapmargin=0
              vim.o.wrap = true
              vim.o.linebreak = true
            end,
          },
        },
      },
    },
  },
  -- Notmuch email address finder (Telescope extension)
  {
    "https://codeberg.org/JoshuaCrewe/telescope-notmuch.nvim.git",
    ft = {'mail'},
    setup = function()
      require("telescope").load_extension("notmuch")
    end,
    dependencies = {"nvim-telescope/telescope.nvim"}
  },
  { "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings
      maps.n["<Leader>fe"] = {
        "<cmd>Telescope notmuch theme=cursor<CR>",
        desc = "[Find] Notmuch Emails"
      }
    end
  }
}
