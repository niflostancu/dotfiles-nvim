return {
  {"nblock/vim-dokuwiki",
    setup=function()
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
              vim.o.textwidth=80
              vim.o.wrapmargin=0
              vim.o.wrap = true
              vim.o.linebreak = true
            end,
          },
        },
      },
    },
  },
}
