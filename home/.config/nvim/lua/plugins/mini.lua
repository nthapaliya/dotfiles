return {
  { "echasnovski/mini-git", opts = {}, name = "mini.git", event = "VeryLazy" },
  { "echasnovski/mini.basics", opts = { options = { extra_ui = true } } },
  { "echasnovski/mini.comment", opts = {}, keys = { "gcc" } },
  { "echasnovski/mini.completion", opts = {}, event = "InsertEnter" },
  { "echasnovski/mini.extra", opts = {} },
  { "echasnovski/mini.icons", opts = {}, event = "VeryLazy" },
  { "echasnovski/mini.splitjoin", opts = {}, keys = { "gS" } },
  { "echasnovski/mini.statusline", opts = {}, event = "VeryLazy" },
  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    opts = {
      view = {
        style = "sign",
        signs = { add = "+", change = "~", delete = "-" },
      },
      mappings = {
        apply = "<leader>hs",
        reset = "<leader>hu",
        textobject = "gh",
        goto_prev = "[c",
        goto_next = "]c",
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({
        symbol = "│",
        draw = {
          delay = 100,
          animation = function()
            return 10
          end,
        },
      })

      local colors = require("catppuccin.palettes").get_palette("mocha")
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = colors.surface1 })
    end,
  },
  {
    "echasnovski/mini.tabline",
    event = "VeryLazy",
    config = function()
      require("mini.tabline").setup({
        format = function(buf_id, label)
          local suffix = vim.bo[buf_id].modified and " " or ""
          return MiniTabline.default_format(buf_id, label) .. suffix
        end,
      })

      local colors = require("catppuccin.palettes").get_palette("mocha")
      -- mini.tabline
      local active = { bg = colors.blue, fg = colors.crust, bold = true }
      local inactive = { bg = colors.surface1, fg = colors.subtext2 }

      vim.api.nvim_set_hl(0, "MiniTablineCurrent", active)
      vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", active)

      vim.api.nvim_set_hl(0, "MiniTablineHidden", inactive)
      vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", inactive)
      vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", inactive)
      vim.api.nvim_set_hl(0, "MiniTablineVisible", inactive)

      vim.api.nvim_set_hl(0, "MiniTablineFill", { bg = colors.mantle, fg = colors.mantle })
    end,
  },
  {
    "echasnovski/mini.notify",
    event = "VeryLazy",
    config = function()
      local opts = { window = { config = { anchor = "SE", row = vim.o.lines - 2 } } }
      require("mini.notify").setup(opts)
      vim.notify = require("mini.notify").make_notify()
    end,
  },
  {
    "echasnovski/mini.align",
    opts = { mappings = { start = "gl", start_with_preview = "gL" } },
    keys = {
      { mode = { "n", "v" }, "gl" },
      { mode = { "n", "v" }, "gL" },
    },
  },
  {
    "echasnovski/mini.misc",
    config = function()
      require("mini.misc").setup()
      MiniMisc.setup_termbg_sync()
      MiniMisc.setup_restore_cursor()
    end,
  },
  {
    "echasnovski/mini.pick",
    cmd = { "Rg" },
    keys = { "<C-t>", "<leader>t" },
    config = function()
      require("mini.pick").setup({
        window = {
          config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
              anchor = "NW",
              height = height,
              width = width,
              row = math.floor(0.5 * (vim.o.lines - height)),
              col = math.floor(0.5 * (vim.o.columns - width)),
            }
          end,
        },
      })

      vim.keymap.set("n", "<C-t>", MiniPick.builtin.files, { silent = true })
      vim.keymap.set("n", "<leader>td", MiniExtra.pickers.diagnostic, { silent = true })
      vim.keymap.set("n", "<leader>tg", function()
        MiniExtra.pickers.git_files({ scope = "modified" })
      end, { silent = true })

      vim.api.nvim_create_user_command("Rg", function(o)
        MiniPick.builtin.grep({ pattern = o.args })
      end, { nargs = "*" })
      vim.ui.select = MiniPick.ui_select
    end,
  },
  {
    "echasnovski/mini.surround",
    keys = { "ys", "ds", "cs" },
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs",
        update_n_lines = "",
        suffix_last = "",
        suffix_next = "",
      },
      search_method = "cover_or_next",
    },
    -- config = function(opts)
    --   require("mini.surround").setup(opts)
    --   vim.keymap.del("x", "ys")
    --   vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
    --   vim.keymap.set("n", "yss", "ys_", { remap = true })
    -- end,
  },
  {
    "echasnovski/mini.files",
    config = function()
      require("mini.files").setup()
      vim.keymap.set("n", "-", MiniFiles.open)
      -- pass
    end,
  },
  { "echasnovski/mini.nvim", lazy = true },
}
