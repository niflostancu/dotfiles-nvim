return {
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.typescript" },

  { "AstroNvim/astrocore",
    opts = {
      filetypes = {
        -- see `:h vim.filetype.add` for usage
        extension = {
          html = "html",
          phtml = "html",
        },
      },
      autocmds = {
        html_ft_options = {
          {
            event = { "FileType" },
            pattern = { "html", "htmldjango" },
            desc = "Custom text formatting options + enable wrapping",
            callback = function()
              vim.o.textwidth=120
              vim.o.wrapmargin=120
              vim.o.wrap = true
              vim.o.linebreak = true
              vim.bo.shiftwidth = 2
              vim.bo.tabstop = 2
              vim.bo.expandtab = true
            end,
          },
        },
      },
    },
  }
}
