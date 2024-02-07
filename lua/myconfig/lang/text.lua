-- TODO: markdown preview https://github.com/ellisonleao/glow.nvim

lvimPlugin({
  "nblock/vim-dokuwiki",
})

lvimPlugin({
  'cameron-wags/rainbow_csv.nvim',
  config = true,
  cmd = {
    'RainbowDelim',
    'RainbowDelimSimple',
    'RainbowDelimQuoted',
    'RainbowMultiDelim'
  },
  filetype = {
    'csv', 'tsv',
    'csv_semicolon', 'csv_whitespace',
    'csv_pipe', 'rfc_csv', 'rfc_semicolon'
  }
})

