return require("packer").startup({
  function()
    use({ "wbthomason/packer.nvim", opt = true })
    use("lewis6991/impatient.nvim")
    use("norcalli/nvim_utils")

    use({ "AndrewRadev/splitjoin.vim", opt = true, keys = { { "n", "gS" }, { "n", "gJ" } } })
    use("airblade/vim-rooter")
    use("christoomey/vim-tmux-navigator")
    use("justinmk/vim-dirvish")
    -- use({ "rbgrouleff/bclose.vim", disable = true })
    use("rstacruz/vim-closer")
    -- use({ "sheerun/vim-polyglot", disable = true })
    use("tommcdo/vim-lion")
    -- use({ "tpope/vim-commentary", disable = true })
    use("tpope/vim-fugitive")
    use("tpope/vim-repeat")
    use("tpope/vim-rhubarb")
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")
    use("unblevable/quick-scope")
    use({ "vim-scripts/BufOnly.vim", opt = true, cmd = { "BufOnly" } })
    use("wincent/terminus")
    use("nvim-lua/plenary.nvim")

    use({
      "akinsho/bufferline.nvim",
      opt = true,
      event = "VimEnter",
      config = require("config.bufferline"),
    })

    use({
      "mhartington/formatter.nvim",
      opt = true,
      cmd = { "FormatWrite" },
      config = require("config.formatter"),
    })

    use({
      "numToStr/Comment.nvim",
      opt = true,
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
      keys = { { "n", "gcc" }, { "n", "gcb" }, { "v", "gc" } },
      config = require("config.Comment"),
    })

    use({
      "williamboman/nvim-lsp-installer",
      requires = { { "neovim/nvim-lspconfig", before = "nvim-lsp-installer" } },
      config = require("config.nvim-lsp-installer"),
    })

    use({
      "lewis6991/gitsigns.nvim",
      opt = true,
      before = { "nvim-lua/plenary.nvim" },
      event = "VimEnter",
      config = require("config.gitsigns"),
    })

    use({
      "nvim-lualine/lualine.nvim",
      opt = true,
      event = "VimEnter",
      config = require("config.lualine"),
    })

    use({
      "nvim-telescope/telescope.nvim",
      opt = true,
      before = { "nvim-lua/plenary.nvim" },
      cmd = { "Telescope" },
      config = require("config.telescope"),
    })

    use({
      "folke/tokyonight.nvim",
      -- opt = true,
      -- event = "VimEnter",
      branch = "main",
      config = require("config.tokyonight"),
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      run = ":TSUpdate",
      config = require("config.nvim-treesitter"),
    })

    use({
      "andymass/vim-matchup",
      after = "nvim-treesitter",
      config = require("config.vim-matchup"),
    })

    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

    use({
      "folke/trouble.nvim",
      opt = true,
      cmd = { "Trouble", "TroubleToggle" },
      config = require("config.trouble"),
    })

    use({
      { "L3MON4D3/LuaSnip", before = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-lsp-installer" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    })

    use({
      "hrsh7th/nvim-cmp",
      opt = true,
      event = "InsertEnter",
      config = require("config.nvim-cmp"),
    })
  end,
  config = {
    display = { open_fn = require("packer.util").float },
    profile = { enable = true },
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
