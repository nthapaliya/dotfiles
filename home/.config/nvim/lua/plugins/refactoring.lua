return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
  },
  keys = {
    {
      "<leader>rf",
      function()
        require("refactoring").select_refactor()
      end,
      mode = "v",
      noremap = true,
      silent = true,
      expr = false,
      desc = "refactoring: Select refactor",
    },
  },
  config = true,
}
