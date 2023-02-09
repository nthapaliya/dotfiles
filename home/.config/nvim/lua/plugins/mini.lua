return {
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({})
    end,
  },

  {
    "echasnovski/mini.basics",
    version = false,
    lazy = false,
    config = function()
      require("mini.basics").setup({
        options = { extra_ui = true },
        autocommands = { basic = false },
      })
    end,
  },

  {
    "echasnovski/mini.comment",
    version = false,
    keys = { { "gc", mode = { "n", "v" } } },
    config = function()
      require("mini.comment").setup({})
    end,
  },

  {
    "echasnovski/mini.cursorword",
    version = false,
    event = "VeryLazy",
    config = function()
      -- unhighlight first two lines
      require("mini.cursorword").setup({ delay = 300 })
      vim.cmd([[highlight MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE]])
      -- vim.cmd([[highlight MiniCursorword gui=nocombine guifg=NONE guibg=NONE]])
    end,
  },

  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        draw = {
          delay = 100,
          animation = function()
            return 10
          end,
        },
      })
      vim.cmd([[highlight MiniIndentscopeSymbol guifg=#3b4261]])
    end,
  },

  {
    "echasnovski/mini.pairs",
    version = false,
    lazy = true,
    -- event = "VeryLazy",
    config = function()
      require("mini.pairs").setup({})
    end,
  },

  {
    "echasnovski/mini.surround",
    -- maybe keys, but VeryLazy is fine
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          update_n_lines = "",
          suffix_last = "",
          suffix_next = "",
        },
        search_method = "cover_or_next",
      })
      -- Remap adding surrounding to Visual mode selection
      vim.api.nvim_del_keymap("x", "ys")
      vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
      -- Make special mapping for "add surrounding for line"
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })
    end,
  },
}
