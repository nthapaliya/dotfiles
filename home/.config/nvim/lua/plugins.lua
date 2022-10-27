local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup({
  function(use)
    -- important ones
    use({ "wbthomason/packer.nvim" })
    use({ "lewis6991/impatient.nvim" })
    use({ "nvim-lua/plenary.nvim" })

    -- basic utils
    use({ "AndrewRadev/splitjoin.vim", opt = true, keys = { { "n", "gS" }, { "n", "gJ" } } })
    use({ "airblade/vim-rooter" })
    use({ "aymericbeaumet/vim-symlink" })
    use({ "christoomey/vim-tmux-navigator" })
    use({
      "elihunter173/dirbuf.nvim",
      opt = true,
      keys = { "-" },
      config = function()
        require("dirbuf").setup({ write_cmd = "DirbufSync -confirm" })
      end,
    })
    use({ "rstacruz/vim-closer" })
    use({ "tommcdo/vim-lion" })
    use({
      "unblevable/quick-scope",
      config = function()
        vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      end,
    })
    use({ "wincent/terminus" })
    use({ "ojroques/vim-oscyank" })
    use({
      "echasnovski/mini.nvim",
      config = function()
        require("mini.cursorword").setup({ delay = 500 })
      end,
    })

    -- tpope
    use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })
    use({ "tpope/vim-endwise" })
    use({ "tpope/vim-fugitive" })
    use({ "tpope/vim-repeat" })
    use({ "tpope/vim-rhubarb" })
    use({ "tpope/vim-sleuth" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-unimpaired" })

    -- buffers
    use({ "moll/vim-bbye", opt = true, cmd = { "Bdelete" } })
    use({ "vim-scripts/BufOnly.vim", opt = true, cmd = { "BufOnly" } })

    -- fuzzy finders
    use({ "ibhagwan/fzf-lua", opt = true, cmd = { "FzfLua" }, requires = { "kyazdani42/nvim-web-devicons" } })
    use({ "nvim-telescope/telescope.nvim" })

    -- lsp
    use({
      "VonHeikemen/lsp-zero.nvim",
      after = "vim-tmux-navigator",
      requires = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },

        -- Snippets
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
      },
      config = require("config/lsp-zero"),
    })

    -- visual niceties
    use({
      "lewis6991/gitsigns.nvim",
      opt = true,
      requires = { "nvim-lua/plenary.nvim" },
      event = "VimEnter",
      config = require("config/gitsigns"),
    })

    use({
      "ggandor/leap.nvim",
      config = function()
        require("leap").add_default_mappings()
      end,
    })

    use({
      "ojroques/nvim-hardline",
      config = function()
        require("hardline").setup({
          bufferline = true,
          bufferline_settings = {
            separator = "",
          },
        })
      end,
    })

    use({
      "rebelot/kanagawa.nvim",
      config = function()
        vim.cmd([[colorscheme kanagawa]])
      end,
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
      keys = { { "n", "gcc" }, { "n", "gcb" }, { "v", "gc" } },
      config = function()
        require("Comment").setup()
      end,
    })

    -- Honorable mentions
    -- use({ "junegunn/fzf.vim", requires = "junegunn/fzf" })
    -- use({ "rbgrouleff/bclose.vim", disable = true })
    -- use({ "sheerun/vim-polyglot", disable = true })
    -- use({ "tpope/vim-commentary", disable = true })

    -- Bootstrapping packer
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    -- display = { open_fn = require("packer.util").float },
    profile = { enable = true },
    -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})
