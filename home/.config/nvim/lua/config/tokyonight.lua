return function()
  vim.g.tokyonight_colors = {
    gitSigns = {
      add = "#00ff00",
      change = "#00eeff",
      delete = "#ff4b2b",
    },
  }
  vim.cmd([[colorscheme tokyonight]])
end
