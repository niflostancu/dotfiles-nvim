
lvimPlugin({
  "ms-jpq/coq_nvim",
  branch = "coq",
  dependencies = {'nvim-lua/plenary.nvim', "sindrets/diffview.nvim" },
})

lvimPlugin({
  "ms-jpq/coq.artifacts",
  branch = "artifacts",
  dependencies = { "ms-jpq/coq_nvim" },
})

