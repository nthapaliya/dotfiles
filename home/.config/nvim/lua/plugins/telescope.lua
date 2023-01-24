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
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    opts = {
      pickers = {
        find_files = {
          find_command = { "fd", "-H", "--type", "file" },
        },
      },
    },
    cmd = { "Telescope" },
    keys = {
      { "<C-t>", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      { "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    },
  },
}
