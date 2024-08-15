return {
  -- basic utils
  "tpope/vim-sleuth", -- TODO: Lazy

  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-repeat", keys = { "." } },

  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("smart-splits").setup()
      -- decide if I really need these
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
      -- moving between splits
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      -- vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
      -- swapping buffers between windows
      -- vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
      -- vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
      -- vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
      -- vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
  },

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
