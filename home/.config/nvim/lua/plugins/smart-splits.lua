return {
  "mrjones2014/smart-splits.nvim",
  init = function()
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Smart Splits: Resize left" })
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Smart Splits: Resize down" })
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Smart Splits: Resize up" })
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Smart Splits: Resize right" })
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Smart Splits: Move left" })
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Smart Splits: Move down" })
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Smart Splits: Move up" })
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Smart Splits: Move right" })
  end,
  opts = {},
}
