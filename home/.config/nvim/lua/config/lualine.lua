return function()
  require("lualine").setup({
    options = {
      icons_enabled = false,
      theme = "tokyonight",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  })
end
