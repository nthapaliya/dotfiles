return {
  -- basic utils
  "tpope/vim-sleuth", -- TODO: Lazy

  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-repeat", keys = { "." } },

  {
    "christoomey/vim-tmux-navigator",
    cond = function()
      return vim.env.TMUX ~= nil
    end,
  }, -- TODO: lazy

  {
    "stevearc/oil.nvim",
    config = true,
    keys = { {
      "-",
      "<cmd>Oil --float<cr>",
      desc = "oil.nvim: Open parent directory",
    } },
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

  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
