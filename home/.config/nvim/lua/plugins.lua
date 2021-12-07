return require('packer').startup({ function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  use 'AndrewRadev/splitjoin.vim'
  use 'airblade/vim-rooter'
  use {
    'andymass/vim-matchup',
    after = "nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        matchup = {
          enable = true,
        }
      }
    end
  }
  use 'christoomey/vim-tmux-navigator'
  use { 'junegunn/fzf', disable = true }
  use { 'junegunn/fzf.vim', disable = true }
  use 'justinmk/vim-dirvish'
  use { 'rbgrouleff/bclose.vim', disable = true }
  use 'rstacruz/vim-closer'
  use 'sheerun/vim-polyglot'
  use 'tommcdo/vim-lion'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'unblevable/quick-scope'
  use 'vim-scripts/BufOnly.vim'
  use 'wincent/terminus'

  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'neovim/nvim-lspconfig'
  use 'saadparwaiz1/cmp_luasnip'
  use 'williamboman/nvim-lsp-installer'

  use { 'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require'gitsigns'.setup({
          signs = {
            add = { text = '+' },
            change = { text = '~' },
          },
          keymaps = {
            ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
            ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},
            ['n <leader>hr'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
            ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
            ['n <leader>hu'] = '<cmd>Gitsigns reset_hunk<CR>',
            ['v <leader>hs'] = ':Gitsigns stage_hunk<CR>',
            ['v <leader>hu'] = ':Gitsigns reset_hunk<CR>',
          },
        })
    end
  }

  use { 'nvim-lualine/lualine.nvim',
    config = function() require'lualine'.setup({
          options = {
            icons_enabled = false,
            theme = 'tokyonight',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
          },
          tabline = {
            lualine_a = {'filename'},
            lualine_y = {'buffers'},
            lualine_z = {'tabs'}
          }
        })
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      require('telescope').setup{
        defaults = {
          layout_strategy = 'flex',
        },
        pickers = {
          find_files = {
            hidden = true,
            -- path_display = {'shorten'},
          }
        },
      }
    end
  }

  use { 'folke/tokyonight.nvim', branch = 'main' }
  -- use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', run = ':TSUpdate' }
  use { 'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'} }
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        signs = {
          error = "error",
          warning = "warn",
          hint = "hint",
          information = "info"
        },
        use_lsp_diagnostic_signs = false
      }
    end
  }
end,
config = { display = { open_fn = require('packer.util').float } }
})
