return {
  {
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
        ufo = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        mini = { enabled = true },
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- basic utils
  "tpope/vim-sleuth", -- TODO: Lazy
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-repeat", keys = { "." } },

  {
    "mrjones2014/smart-splits.nvim",
    init = function()
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Smart Splits: Resize left" })
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Smart Splits: Resize down" })
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Smart Splits: Resize up" })
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Smart Splits: Resize right" })
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Smart Splits: Move left" })
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Smart Splits: Move down" })
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Smart Splits: Move up" })
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Smart Splits: Move right" })
    end,
    opts = {},
  },

  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- buffers
  { "numToStr/BufOnly.nvim", cmd = "BufOnly" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufRead",
    init = function()
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    config = function()
      require("ufo").setup({
        --                  function(bufnr, filetype, buftype)
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: Open all Folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: Close all Folds" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context", opts = {} },
      {
        "andymass/vim-matchup",
        init = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      indent = { enable = true },
      highlight = { enable = true },
      -- Third party mods
      matchup = { enable = true },
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent", "shellcheck" },
        go = { "goimports" },
        java = { "google-java-format" },
        json = { "jq" },
        lua = { "stylua" },
        ruby = { "rubyfmt" },
        rust = { "rustfmt" },
        ["*"] = { "trim_newlines", "trim_whitespace" },
      },
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = { timeout_ms = 500 },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
