return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.basics").setup({
      options = { extra_ui = true, },
      autocommands = { basic = false },
    })
    require("mini.ai").setup({})
    require("mini.comment").setup({})

    -- disable this for now, it's kind of annoying
    -- require("mini.pairs").setup({})

    -- mini.cursorword
    -- unhighlight first two lines
    -- require('mini.cursorword').setup({ delay = 300 })
    -- vim.cmd([[highlight MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE]])
    -- vim.cmd([[highlight MiniCursorword gui=nocombine guifg=NONE guibg=NONE]])

    -- mini.bufremove
    require("mini.bufremove").setup({})
    vim.keymap.set("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end, {})
    vim.keymap.set("n", "<leader>bD", function() require("mini.bufremove").delete(0, true) end, {})

    -- mini.surround
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

    -- mini.indentscope
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
}
