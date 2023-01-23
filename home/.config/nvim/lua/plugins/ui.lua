return {
  -- colorschemes
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end,
  },

  -- UI/cosmetic

  {
    "ojroques/nvim-hardline",
    enabled = false,
    opts = {
      bufferline = true,
      bufferline_settings = {
        separator = "",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        -- icons_enabled = false,
        section_separators = "",
        component_separators = "",
      },
      tabline = {
        lualine_a = { "buffers" },
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        lualine_z = { { "filename", path = 1 } },
      },
      -- TODO: look up winbars
    },
  },
}
