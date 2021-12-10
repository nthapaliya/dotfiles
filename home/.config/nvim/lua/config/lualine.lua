return function()
  require("lualine").setup({
    options = {
      icons_enabled = false,
      theme = "tokyonight",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    tabline = {
      lualine_a = { "filename" },
      lualine_y = { "buffers" },
      lualine_z = { "tabs" },
    },
  })
end
