return function()
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
    },
    keymaps = {
      ["n ]c"] = {
        expr = true,
        "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
      },
      ["n [c"] = {
        expr = true,
        "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
      },
      ["n <leader>hr"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
      ["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
      ["n <leader>hu"] = "<cmd>Gitsigns reset_hunk<CR>",
      ["v <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
      ["v <leader>hu"] = "<cmd>Gitsigns reset_hunk<CR>",
    },
  })
end
