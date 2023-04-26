return {
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup()
    end,
  },

  {
    "echasnovski/mini.indentscope",
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

  { "echasnovski/mini.misc", lazy = true },

  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    config = function()
      require("mini.splitjoin").setup({})
    end,
  },

  {
    "echasnovski/mini.surround",
    -- maybe keys, but VeryLazy is fine
    event = "VeryLazy",
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
      vim.keymap.del("x", "ys")
      vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
      -- Make special mapping for "add surrounding for line"
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
  },
}
