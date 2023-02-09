return {
  -- colorschemes
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("tokyonight").setup({
        style = "night",
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
      })
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
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        -- icons_enabled = false,
        section_separators = " ",
        component_separators = " ",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            on_click = function()
              vim.diagnostic.setqflist()
            end,
          },
        },
        lualine_c = { { "filename", path = 1 } },
        -- lualine_x = { "filetype", "encoding", "fileformat" },
        -- lualine_y = { "progress" },
        -- lualine_z = { "location" },
      },
      tabline = {
        lualine_a = { "buffers" },
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = { { "filename", path = 1 } },
      },
      -- TODO: look up winbars
    },
  },

  -- TODO: look up if this needs more configuration
  -- { "stevearc/dressing.nvim", config = true },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    -- event = "VeryLazy",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false,
        attach_navic = false,
      })
      vim.api.nvim_create_autocmd({
        "CursorHold",
        "InsertLeave",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
}
