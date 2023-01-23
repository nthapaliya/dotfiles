local init = function()
  vim.wo.foldlevel = 20
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

  -- Third party mods
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

local opts = {
  ensure_installed = {
    "bash",
    "fish",
    "lua",
    "ruby",
    "rust",
    "vim",
  },
  indent = { enable = true },
  highlight = { enable = true },

  -- Third party mods
  matchup = { enable = true },
}

-- treesitter
-- slow
return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  dependencies = { "andymass/vim-matchup" },
  build = ":TSUpdate",
  init = init,
  opts = opts,
}
