return {
  -- basic utils
  "tpope/vim-sleuth", -- TODO: Lazy
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-repeat", keys = { "." } },

  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- buffers
  { "numToStr/BufOnly.nvim", cmd = "BufOnly" },
  { "GCBallesteros/jupytext.nvim", config = true },
}
