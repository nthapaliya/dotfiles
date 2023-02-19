return {
  {
    "echasnovski/mini.comment",
    keys = { { "gc", mode = { "n", "v" } } },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup({
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
      require("mini.comment").setup(opts)
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
      vim.api.nvim_del_keymap("x", "ys")
      vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
      -- Make special mapping for "add surrounding for line"
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })
    end,
  },
}
