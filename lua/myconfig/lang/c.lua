-- Syntax / LSP / IDE features configuration for C / C++

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

local clangd_flags = {
  "--query-driver=/usr/bin/arm-none-eabi-gcc",
  "--enable-config"
}

local clangd_bin = "clangd"

local custom_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)
  -- local opts = { noremap = true, silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}

local excludes = vim.tbl_get(lvim.lsp.installer.setup, "automatic_installation", "exclude")
if not (excludes and vim.tbl_contains(excludes, "clangd")) then
  require("lvim.lsp.manager").setup("clangd", opts)

  -- Configure debugging
  local ok, dap_install = pcall(require, 'dap-install')
  if ok then
    dap_install.config("ccppr_vsc", {
      adapters = {
        type = "executable",
      },
      configurations = {
        {
          type = "cpptools",
          request = "launch",
          name = "Launch with pretty-print",
          program = function()
            return vim.fn.input('Path to exe: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          setupCommands = {
            {
              description = "Enable pretty-printing",
              text = "-enable-pretty-printing",
            }
          }
        },
      }
    })
  end

end
