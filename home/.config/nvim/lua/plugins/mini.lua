return {
  { "nvim-mini/mini-git", opts = {}, name = "mini.git", event = "VeryLazy" },
  { "nvim-mini/mini.basics", opts = { options = { extra_ui = true } } },
  { "nvim-mini/mini.comment", opts = {}, keys = { "gcc" } },
  { "nvim-mini/mini.completion", opts = {}, event = "InsertEnter" },
  { "nvim-mini/mini.extra", opts = {} },
  { "nvim-mini/mini.icons", opts = {}, event = "VeryLazy" },
  { "nvim-mini/mini.splitjoin", opts = {}, keys = { "gS" } },
  { "nvim-mini/mini.statusline", opts = {}, event = "VeryLazy" },
  { "nvim-mini/mini.ai", opts = {}, event = "VeryLazy" },
  {
    "nvim-mini/mini.diff",
    event = "VeryLazy",
    opts = {
      view = {
        style = "sign",
        signs = { add = "+", change = "~", delete = "-" },
      },
      mappings = {
        apply = "<leader>hs",
        reset = "<leader>hu",
        -- textobject = "gh",
        goto_first = "[C",
        goto_prev = "[c",
        goto_next = "]c",
        goto_last = "]C",
      },
    },
  },
  {
    "nvim-mini/mini.indentscope",
    event = "VeryLazy",
    opts = { symbol = "│" },
  },
  {
    "nvim-mini/mini.tabline",
    event = "VeryLazy",
    opts = {
      format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and " " or ""
        return MiniTabline.default_format(buf_id, label) .. suffix
      end,
    },
  },
  {
    "nvim-mini/mini.notify",
    event = "VeryLazy",
    config = function()
      local opts = { window = { config = { anchor = "SE", row = vim.o.lines - 2 } } }
      require("mini.notify").setup(opts)
      vim.notify = require("mini.notify").make_notify()
    end,
  },
  {
    "nvim-mini/mini.align",
    opts = { mappings = { start = "gl", start_with_preview = "gL" } },
    keys = {
      { mode = { "n", "v" }, "gl" },
      { mode = { "n", "v" }, "gL" },
    },
  },
  {
    "nvim-mini/mini.pick",
    cmd = { "Rg" },
    keys = {
      { "<C-t>", desc = "Open file picker" },
      { "<leader>td", desc = "Open diagnostic picker" },
      { "<leader>tg", desc = "Open git_files (modified) picker" },
    },
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
    "nvim-mini/mini.surround",
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
  },
  {
    "nvim-mini/mini.files",
    opts = {},
    init = function()
      vim.keymap.set("n", "-", function()
        MiniFiles.open()
      end, { desc = "MiniFiles: explore current directory" })
    end,
  },
  {
    "nvim-mini/mini.misc",
    lazy = true,
    opts = {},
  },

  { "nvim-mini/mini.nvim", lazy = true },
}
