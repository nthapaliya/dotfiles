return function()
  require("telescope").setup({
    defaults = {
      layout_strategy = "flex",
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
    },
  })
end
