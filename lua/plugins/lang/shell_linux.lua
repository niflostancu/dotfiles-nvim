return {
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  -- fix docker-language-server not valid in mason-lspconfig
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      for k,v in ipairs(opts.ensure_installed) do
        if v == 'docker-language-server' then
          table.remove(opts.ensure_installed, k)
          break
        end
      end
    end,
  },
}

