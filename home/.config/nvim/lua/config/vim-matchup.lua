return function()
  require("nvim-treesitter.configs").setup({ matchup = { enable = true } })
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end
