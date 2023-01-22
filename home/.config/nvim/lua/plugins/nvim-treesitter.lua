M = {}

M.treesitter_init = function()
  vim.wo.foldlevel = 20
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

  -- Third party mods
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

M.treesitter_opts = {
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
  build = function()
    pcall(require("nvim-treesitter.install").update({ with_sync = true }))
  end,
  init = M.treesitter_init,
  opts = M.treesitter_opts,
}
