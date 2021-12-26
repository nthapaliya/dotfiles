return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    indent = { enable = true },
    highlight = { enable = true, },
  })

  vim.wo.foldlevel = 20
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
end
