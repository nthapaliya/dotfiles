-- slow
return {
  -- fuzzy finders
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    enabled = false,
    keys = {
      { "<C-t>", "<cmd>Files<cr>" },
      { "<leader>g", "<cmd>GFiles?<cr>" },
      { "<leader>b", "<cmd>Buffers<cr>" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      pickers = {
        find_files = {
          find_command = { "fd", "-H", "--type", "file" },
        },
      },
    },
    keys = {
      { "<C-t>", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      { "<leader>g", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    },
  },
}
