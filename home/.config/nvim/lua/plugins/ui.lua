return {
  -- colorschemes
  {
    "folke/tokyonight.nvim",
    -- priority = 1000,
    lazy = true,
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

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
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
          gitsigns = true,
          treesitter = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      vim.cmd.colorscheme("catppuccin")
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
      -- winbar = {
      --   lualine_a = {
      --     {
      --       function()
      --         return " "
      --       end,
      --       color = { bg = "NONE" },
      --     },
      --     {
      --       function()
      --         return require("nvim-navic").get_location()
      --       end,
      --       cond = function()
      --         return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
      --       end,
      --       color = { bg = "NONE" },
      --     },
      --   },
      -- },
    },
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      -- vim.g.navic_silence = true
      M.on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ❯ ",
        highlight = true,
        depth_limit = 5,
      }
    end,
  },

  -- TODO: look up if this needs more configuration
  -- { "stevearc/dressing.nvim", config = true },

  -- TODO, simplify this by only using navic?
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        attach_navic = false,
        create_autocmd = false,
        -- show_dirname = false,
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
  { "j-hui/fidget.nvim", event = "VeryLazy", config = true },
}
