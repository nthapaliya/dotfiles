return require("packer").startup({
  function()
    -- important ones
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "lewis6991/impatient.nvim" })
    use({ "nvim-lua/plenary.nvim" })

    -- basic utils
    use({ "AndrewRadev/splitjoin.vim", opt = true, keys = { { "n", "gS" }, { "n", "gJ" } } })
    use({ "airblade/vim-rooter" })
    use({ "aymericbeaumet/vim-symlink" })
    use({ "christoomey/vim-tmux-navigator" })
    use({ "justinmk/vim-dirvish" })
    use({ "rstacruz/vim-closer" })
    use({ "tommcdo/vim-lion" })
    use({ "unblevable/quick-scope" })
    use({ "wincent/terminus" })

    -- tpope
    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })
    use({ "tpope/vim-endwise" })
    use({ "tpope/vim-fugitive" })
    use({ "tpope/vim-repeat" })
    use({ "tpope/vim-rhubarb" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-unimpaired" })

    -- buffers
    use({ "moll/vim-bbye", opt = true, cmd = { "Bdelete" } })
    use({ "vim-scripts/BufOnly.vim", opt = true, cmd = { "BufOnly" } })

    -- fuzzy finders
    use({ "ibhagwan/fzf-lua", opt = true, cmd = { "FzfLua" }, requires = { "kyazdani42/nvim-web-devicons" } })

    use({
      "nvim-telescope/telescope.nvim",
      opt = true,
      requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
      cmd = { "Telescope" },
      config = require("config/telescope"),
    })

    -- visual niceties
    use({
      "akinsho/bufferline.nvim",
      opt = true,
      requires = { "kyazdani42/nvim-web-devicons" },
      event = "VimEnter",
      config = require("config/bufferline"),
    })

    use({
      "lewis6991/gitsigns.nvim",
      opt = true,
      requires = { "nvim-lua/plenary.nvim" },
      event = "VimEnter",
      config = require("config/gitsigns"),
    })

    use({
      "nvim-lualine/lualine.nvim",
      opt = true,
      requires = { "kyazdani42/nvim-web-devicons" },
      event = "VimEnter",
      config = require("config/lualine"),
    })

    use({
      "folke/tokyonight.nvim",
      -- opt = true,
      -- event = "VimEnter",
      branch = "main",
      config = require("config/tokyonight"),
    })

    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      run = ":TSUpdate",
      config = require("config/nvim-treesitter"),
    })

    -- lsp
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = require("config/null-ls"),
    })

    use({
      "williamboman/nvim-lsp-installer",
      requires = "neovim/nvim-lspconfig",
      config = require("config/nvim-lsp-installer"),
    })

    -- compleitions
    use({
      "hrsh7th/nvim-cmp",
      opt = true,
      event = "InsertEnter",
      config = require("config/nvim-cmp"),
      requires = {
        { "L3MON4D3/LuaSnip" },
        { "onsails/lspkind-nvim" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lua" },
        { "saadparwaiz1/cmp_luasnip" },
        -- { "hrsh7th/cmp-cmdline" },
      },
    })

    -- other
    use({
      "mhartington/formatter.nvim",
      opt = true,
      cmd = { "FormatWrite" },
      config = require("config/formatter"),
    })

    use({
      "numToStr/Comment.nvim",
      opt = true,
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
      keys = { { "n", "gcc" }, { "n", "gcb" }, { "v", "gc" } },
      config = require("config/Comment"),
    })

    use({
      "andymass/vim-matchup",
      after = "nvim-treesitter",
      config = require("config/vim-matchup"),
    })

    use({
      "folke/trouble.nvim",
      opt = true,
      cmd = { "Trouble", "TroubleToggle" },
      config = require("config/trouble"),
    })

    use({
      "nvim-orgmode/orgmode",
      after = "nvim-treesitter",
      config = function()
        require("orgmode").setup({
          org_agenda_files = { "~/org/*" },
          org_default_notes_file = "~/org/refile.org",
        })
      end,
    })

    -- Honorable mentions
    -- use({ "junegunn/fzf.vim", requires = "junegunn/fzf" })
    -- use({ "rbgrouleff/bclose.vim", disable = true })
    -- use({ "sheerun/vim-polyglot", disable = true })
    -- use({ "tpope/vim-commentary", disable = true })
  end,
  config = {
    display = { open_fn = require("packer.util").float },
    profile = { enable = true },
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
