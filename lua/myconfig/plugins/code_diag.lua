--[[
  Code diagnostic / testing plugins.
]]

lvim.lsp.diagnostics.virtual_text = true

lvimPlugin({
  "folke/trouble.nvim",
  cmd = "TroubleToggle",
})

-- replace builtin LSP mappings
local find_mappings = {
  [","] = { "<cmd>Telescope lsp_document_symbols<cr>", "[Telescope] Buffer Symbols" },
  t = { "<cmd>TroubleToggle<cr>", "[Trouble] Toggle" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "[Trouble] Workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "[Trouble] Buffer" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "[Trouble] Quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "[Trouble] Loclist" },
  o = { "<cmd>TroubleToggle lsp_references<cr>", "[Trouble] References" },
}
for k,v in pairs(find_mappings) do myconfig.which_key.find.mappings[k] = v end

vim.g.diagnostics_visible = true
local lsp_mappings = {
  name = "LSP / Diagnostics",
  ["d"] = { function() 
    if vim.g.diagnostics_visible then
      vim.g.diagnostics_visible = false
      vim.diagnostic.hide()
    else
      vim.g.diagnostics_visible = true
      vim.diagnostic.show()
    end
  end, "Toggle diagnostics" },
}
for k,v in pairs(lsp_mappings) do lvim.builtin.which_key.mappings["l"][k] = v end

-- add g<key> buffer mappings to use Telescope
lvim.lsp.buffer_mappings.normal_mode["gd"] = {
  "<cmd>Telescope lsp_definitions<cr>", "[Telescope] LSP Definitions"}
lvim.lsp.buffer_mappings.normal_mode["gI"] = {
  "<cmd>Telescope lsp_implementations<cr>", "[Telescope] LSP Implementations"}
lvim.lsp.buffer_mappings.normal_mode["gr"] = {
  "<cmd>Telescope lsp_references<cr>", "[Telescope] LSP References"}

