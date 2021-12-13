return function()
  require("telescope").setup({
    defaults = {
      color_devicons = false,
      layout_strategy = "flex",
      scroll_strategy = "limit",
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-u>"] = false,
        },
      },
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
        dir_icon = "▶",
      },
      -- grep_string = {
      --   additional_args = function()
      --     return { "--hidden" }
      --   end,
      -- },
    },
  })
end
