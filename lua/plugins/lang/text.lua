return {
  -- Markdown TreeSitter + LSP
  { import = "astrocommunity.pack.markdown" },
	-- Markdown Preview
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "quarto", "rmd", "typst", "codecompanion" },
    opts = {
      markdown = {
        enable = true,
      },
      markdown_inline = {
        enable = true,
      },
      preview = {
        enable = true,
        filetypes = { "markdown", "quarto", "rmd", "typst", "codecompanion" },
        ignore_buftypes = {},
        condition = function (buffer)
          local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt
          if bt == "nofile" and ft == "codecompanion" then
            return true
          elseif bt == "nofile" then
            return false
          else
            return nil
          end
        end,
        modes = { "n", "no", "c" },
        hybrid_modes = { "n" },
        linewise_hybrid_mode = false,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed =
          require("astrocore").list_insert_unique(opts.ensure_installed, { "html", "markdown", "markdown_inline" })
        end
      end,
    },
  },
  -- DokuWiki format
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
  -- hex editor ;) 
  { "RaafatTurki/hex.nvim",
    opts = {}
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
