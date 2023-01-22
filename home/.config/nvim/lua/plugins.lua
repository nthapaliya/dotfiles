return {
  -- basic utils
  { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" } },
  "airblade/vim-rooter",
  "aymericbeaumet/vim-symlink",
  "christoomey/vim-tmux-navigator",
  {
    "elihunter173/dirbuf.nvim",
    keys = { "-" },
    opts = { write_cmd = "DirbufSync -confirm" },
  },
  { "tommcdo/vim-lion", keys = { "gl", "gL" } },
  {
    "unblevable/quick-scope",
    keys = { "f", "F", "t", "T" },
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },
  "wincent/terminus",
  {
    "ojroques/vim-oscyank",
    keys = { "y" },
    -- init = function()
    --   vim.g.oscyank_silent = true
    -- end,
  },

  -- tpope
  { "tpope/vim-dispatch", enabled = false },
  "tpope/vim-endwise",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  { "tpope/vim-unimpaired", keys = { "[<space>", "]<space>" } },

  -- buffers
  "moll/vim-bbye",
  "vim-scripts/BufOnly.vim",

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

  -- visual niceties
  {
    "ojroques/nvim-hardline",
    opts = {
      bufferline = true,
      bufferline_settings = {
        separator = "",
      },
    },
  },

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- other
  -- slow
  {
    "numToStr/Comment.nvim",
    keys = { "gcc", "gcb", "gc", { "gc", mode = "v" } },
    config = true,
  },
}
