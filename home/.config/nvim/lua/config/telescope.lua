return function()
  require("telescope").setup({
    defaults = {
      layout_strategy = "flex",
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        -- path_display = {'shorten'},
      },
      file_browser = {
        hidden = true,
        dir_icon = ">>",
      },
      -- grep_string = {
      --   additional_args = function()
      --     return { "--hidden" }
      --   end,
      -- },
    },
  })
end
