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
          navic = { enabled = true },
          native_lsp = { enabled = true },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- UI/cosmetic
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
    opts = {
      separator = " ❯ ",
      highlight = true,
      depth_limit = 5,
    },
  },

  { "j-hui/fidget.nvim", lazy = true },
}
