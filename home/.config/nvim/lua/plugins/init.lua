return {
  -- basic utils
  "airblade/vim-rooter",
  "aymericbeaumet/vim-symlink",
  "christoomey/vim-tmux-navigator",
  "wincent/terminus",

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
    "ojroques/vim-oscyank",
    keys = { "y", { "y", mode = "v" } },
    -- init = function()
    --   vim.g.oscyank_silent = true
    -- end,
  },

  -- tpope
  { "tpope/vim-dispatch", enabled = false },
  { "tpope/vim-endwise", enabled = false },
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  { "tpope/vim-rhubarb", cmd = "GBrowse" },
  "tpope/vim-sleuth",
  { "tpope/vim-unimpaired", keys = { "[<space>", "]<space>" } },

  -- buffers
  { "vim-scripts/BufOnly.vim", cmd = "BufOnly" },

  -- slow
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" } },
    config = true,
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "S", "gs" },
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = true,
  },
}
