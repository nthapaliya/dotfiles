return require("packer").startup({
  function(use)
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
    use({ "rstacruz/vim-closer", opt = true })
    use({ "tommcdo/vim-lion" })
    use({ "unblevable/quick-scope" })
    use({ "wincent/terminus" })
    use({ "ojroques/vim-oscyank" })

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
      "lewis6991/gitsigns.nvim",
      opt = true,
      requires = { "nvim-lua/plenary.nvim" },
      event = "VimEnter",
      config = require("config/gitsigns"),
    })

    -- -- TODO: figure out how to use this one
    -- use("ggandor/lightspeed.nvim")
    --
    use({
      "jose-elias-alvarez/buftabline.nvim",
      event = "VimEnter",
      config = require("config/buftabline"),
    })

    use({
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = require("config/lualine"),
    })

    use({
      "folke/tokyonight.nvim",
      branch = "main",
      config = require("config/tokyonight"),
    })

    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      requires = { "andymass/vim-matchup" },
      run = ":TSUpdate",
      config = require("config/nvim-treesitter"),
    })

    -- lsp
    use({
      "jose-elias-alvarez/null-ls.nvim",
      opt = true,
      after = "coq_nvim",
      requires = "nvim-lua/plenary.nvim",
      config = require("config/null-ls"),
    })

    use({
      "williamboman/nvim-lsp-installer",
      opt = true,
      after = "coq_nvim",
      requires = "neovim/nvim-lspconfig",
      config = require("config/nvim-lsp-installer"),
    })

    -- completions
    use({
      "ms-jpq/coq_nvim",
      branch = "coq",
      opt = true,
      event = "InsertEnter",
      requires = { {
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
      } },
      config = function()
        vim.cmd([[COQnow --shut-up]])
      end,
    })

    -- other
    use({
      "mhartington/formatter.nvim",
      disable = true,
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
      "folke/trouble.nvim",
      opt = true,
      cmd = { "Trouble", "TroubleToggle" },
      config = require("config/trouble"),
    })

    -- Honorable mentions
    -- use({ "junegunn/fzf.vim", requires = "junegunn/fzf" })
    -- use({ "rbgrouleff/bclose.vim", disable = true })
    -- use({ "sheerun/vim-polyglot", disable = true })
    -- use({ "tpope/vim-commentary", disable = true })
  end,
  config = {
    -- display = { open_fn = require("packer.util").float },
    profile = { enable = true },
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
