return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    -- transparent_background = true,
    styles = {
      comments = { "italic" }, -- TODO Look this up
      conditionals = { "italic" },
      loops = {},
      functions = { "bold" },
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = { enabled = true },
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
