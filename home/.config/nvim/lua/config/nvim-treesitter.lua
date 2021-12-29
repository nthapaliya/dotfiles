return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    indent = { enable = true },
    highlight = { enable = true },

    -- Third party mods
    matchup = { enable = true },
  })

  vim.wo.foldlevel = 20
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

  -- Third party mods
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end
