return function()
  require("lualine").setup({
    options = {
      icons_enabled = false,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  })

  require("buftabline").setup({ tab_format = " #{b}#{f} " })
end
