-- Syntax / LSP / IDE features configuration for Go (lang)

local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}
-- run 'TSInstallFromGrammar gotmpl' afterwards

vim.list_extend(lvim.lsp.automatic_configuration.skipped_filetypes, {"gotmpl", "yaml"})

