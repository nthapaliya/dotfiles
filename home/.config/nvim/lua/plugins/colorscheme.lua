return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    highlight_overrides = {
      all = function(colors)
        return {
          MiniTablineCurrent = { bg = colors.blue, fg = colors.crust, style = { "bold" } },
          MiniTablineModifiedCurrent = { bg = colors.blue, fg = colors.crust, style = { "bold" } },
          MiniTablineHidden = { bg = colors.surface0, fg = colors.subtext1 },
          MiniTablineModifiedHidden = { bg = colors.surface0, fg = colors.subtext1 },
          MiniTablineModifiedVisible = { bg = colors.surface0, fg = colors.subtext1 },
          MiniTablineVisible = { bg = colors.surface1, fg = colors.subtext1 },
          MiniTablineFill = { bg = colors.mantle },
          MiniIndentscopeSymbol = { fg = colors.surface1 },
        }
      end,
    },
    default_integrations = false,
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    integrations = {
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      native_lsp = {
        enabled = true,
        virtual_text = {},
        underlines = {},
        inlay_hints = { background = true },
      },
      mini = { enabled = true },
    },
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
