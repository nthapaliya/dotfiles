return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  keys = {
    {
      "<leader>re",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
      desc = "refactor: extract function",
      mode = "v",
    },
    {
      "<leader>rf",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
      desc = "refactor: extract function to file",
      mode = "v",
    },
    {
      "<leader>rv",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
      desc = "refactor: extract variable",
      mode = "v",
    },
    {
      "<leader>ri",
      [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
      desc = "refactor: inline variable",
      mode = "v",
    },
    {
      "<leader>rb",
      [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
      desc = "refactor: extract block",
    },
    {
      "<leader>rbf",
      [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
      desc = "refactor: extract block to file",
    },
    {
      "<leader>ri",
      [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
      desc = "refactor: inline variable",
    },
  },
  config = true,
}
