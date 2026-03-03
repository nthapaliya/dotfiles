return {
  -- basic utils
  "tpope/vim-sleuth", -- TODO: Lazy
  -- { "tpope/vim-fugitive", event = "VeryLazy" },
  -- { "tpope/vim-repeat", keys = { "." } },

  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- buffers
  { "numToStr/BufOnly.nvim", cmd = "BufOnly" },
  -- { "goerz/jupytext.nvim", version = "0.2.0", opts = { format = "md:myst" } },
  { "goerz/jupytext.nvim", version = "0.2.0", opts = { format = "markdown" } },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
