return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead",
  dependencies = {
    -- { "nvim-treesitter/nvim-treesitter-context", opts = {} },
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
  },
  build = ":TSUpdate",
  opts = {
    auto_install = true,
    indent = { enable = true },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    -- Third party mods
    matchup = { enable = true },
  },
}
