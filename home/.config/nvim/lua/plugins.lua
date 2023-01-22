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
    use({ "AndrewRadev/splitjoin.vim" })
    use({ "airblade/vim-rooter" })
    use({ "aymericbeaumet/vim-symlink" })
    use({ "christoomey/vim-tmux-navigator" })
    use({
      "elihunter173/dirbuf.nvim",
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
    use({
      "ojroques/vim-oscyank",
      -- config = function()
      --   vim.g.oscyank_silent = true
      -- end,
    })

    -- tpope
    use({ "tpope/vim-dispatch" })
    use({ "tpope/vim-endwise" })
    use({ "tpope/vim-fugitive" })
    use({ "tpope/vim-repeat" })
    use({ "tpope/vim-rhubarb" })
    use({ "tpope/vim-sleuth" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-unimpaired" })

    -- buffers
    use({ "moll/vim-bbye" })
    use({ "vim-scripts/BufOnly.vim" })

    -- fuzzy finders
    use({
      "junegunn/fzf.vim",
      requires = "junegunn/fzf",
      config = function()
        vim.keymap.set("n", "<C-t>", ":Files<cr>")
        vim.keymap.set("n", "<leader>g", ":GFiles?<cr>")
        vim.keymap.set("n", "<leader>b", ":Buffers<cr>")
      end,
    })

    use({ "nvim-telescope/telescope.nvim" })

    -- lsp
    -- TODO: slow, but don't make lazy yet
    use({
      "neovim/nvim-lspconfig",
      requires = {
        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Additional plugins
        "folke/neodev.nvim",
        "j-hui/fidget.nvim",
        "lukas-reineke/lsp-format.nvim",
      },
      config = require("config/nvim-lspconfig"),
    })

    -- slow
    use({
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      opt = true,
      keys = { { "n", "<leader>tt" } },
      config = function()
        require("trouble").setup({})

        vim.keymap.set("n", "<leader>tt", ":TroubleToggle<cr>")
      end,
    })

    use({
      "ms-jpq/coq_nvim",
      branch = "coq",
    })

    use({
      "ms-jpq/coq.artifacts",
      branch = "artifacts",
    })

    -- visual niceties
    -- slow
    use({
      "lewis6991/gitsigns.nvim",
      opt = true,
      event = "VimEnter",
      requires = { "nvim-lua/plenary.nvim" },
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
    -- slow
    use({
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      requires = { "andymass/vim-matchup" },
      run = function()
        pcall(require("nvim-treesitter.install").update({ with_sync = true }))
      end,
      config = require("config/nvim-treesitter"),
    })

    -- other
    -- slow
    use({
      "mhartington/formatter.nvim",
      opt = true,
      cmd = { "FormatWrite" },
      config = require("config/formatter"),
    })

    -- slow
    use({
      "numToStr/Comment.nvim",
      opt = true,
      keys = { { "n", "gcc" }, { "n", "gcb" }, { "v", "gc" } },
      config = function()
        require("Comment").setup()
      end,
    })

    -- Honorable mentions
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
