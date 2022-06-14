--[[
  Language-specific / IDE features configuration.
]]

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
  "css", "rust", "java", "yaml",
}
lvim.builtin.treesitter.highlight.enabled = true
-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- show current function at the top of the screen when function does not fit in screen
lvimPlugin({
  "romgrk/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup{
      enable = true,
      throttle = true,
      max_lines = 0,
      patterns = {
        default = { 'class', 'function', 'method', },
      },
    }
  end
})

-- show function signature as you type
lvimPlugin({
  "ray-x/lsp_signature.nvim",
  event = "BufRead",
  config = function()
    require "lsp_signature".setup()
  end
})

lvimPlugin({
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
})

