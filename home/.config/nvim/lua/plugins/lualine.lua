return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      -- icons_enabled = false,
      -- section_separators = " ",
      section_separators = { left = "", right = "" },
      component_separators = "",
      globalstatus = true,
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
        { "b:gitsigns_head", icon = "" },
        {
          "diff",
          source = function()
            local gitsigns = vim.b["gitsigns_status_dict"]
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
        {
          "diagnostics",
          on_click = function()
            vim.diagnostic.setqflist()
          end,
        },
      },
      lualine_c = {
        { "filename", path = 1 },
        -- {
        --   function()
        --     return require("nvim-navic").get_location()
        --   end,
        --   cond = function()
        --     return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
        --   end,
        --   color = { bg = "NONE" },
        -- },
      },
      lualine_x = { "filetype" },
      lualine_y = {
        { "encoding", padding = { left = 1, right = 0 } },
        {
          "fileformat",
          icons_enabled = true,
          symbols = {
            unix = "unix",
            dos = "dos",
            mac = "mac",
          },
          padding = { left = 1, right = 1 },
        },
      },
      lualine_z = {
        { "progress", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
    },
    tabline = {
      lualine_a = { { "buffers", mode = 2 } },
    },
  },
}
