return {
  -- basic utils
  { "airblade/vim-rooter", enabled = false },
  { "aymericbeaumet/vim-symlink", dependencies = { "moll/vim-bbye" } }, -- TODO: lazy
  "christoomey/vim-tmux-navigator", -- TODO: lazy
  "tpope/vim-sleuth", -- TODO: Lazy

  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-repeat", keys = { "." } },

  {
    "AndrewRadev/splitjoin.vim",
    keys = { { "gS", desc = "splitjoin: Split line" }, { "gJ", desc = "Splitjoin: join line" } },
  },

  {
    "elihunter173/dirbuf.nvim",
    keys = { "-" },
    opts = { write_cmd = "DirbufSync -confirm" },
  },

  {
    "tommcdo/vim-lion",
    keys = {
      { "gl", desc = "vim-lion: align by adding spaces to the left" },
      { "gL", desc = "vim-lion: align by adding spaces to the right" },
    },
  },

  {
    "unblevable/quick-scope",
    keys = { "f", "F", "t", "T" },
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },

  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  {
    "ibhagwan/smartyank.nvim",
    event = "TextYankPost",
    opts = { highlight = { timeout = 200 } },
  },

  -- buffers
  { "numToStr/BufOnly.nvim", cmd = "BufOnly" },

  {
    "ggandor/leap.nvim",
    keys = { "s", "S", "gs" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = true,
  },
}
