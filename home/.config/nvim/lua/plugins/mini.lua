return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup({})
    require("mini.bufremove").setup({})
    require("mini.comment").setup({})
    require("mini.pairs").setup({})
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
    vim.cmd([[highlight MiniIndentscopeSymbol guifg=#3b4261]])
    require("mini.indentscope").setup({
      symbol = "│",
      draw = {
        delay = 100,
        animation = function()
          return 10
        end,
      },
    })
  end,
}
