-- General ====================================================================
vim.g.mapleader = ' '
vim.o.undofile = false
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- UI =========================================================================
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.listchars = 'extends:#,nbsp:·,tab:▸·,trail:·'
vim.o.colorcolumn = '+1' -- Draw column on the right of maximum width
vim.o.pumborder = 'single' -- Use border in popup menu
vim.o.pummaxwidth = 100 -- Make popup menu not too wide
vim.o.winborder = 'single' -- Use border in floating windows
vim.o.cursorlineopt = 'screenline,number' -- Show cursor line per screen line
vim.o.cursorline = false
vim.o.wrap = true

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'indent' -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = '' -- Show text under fold with its highlighting

-- Editing ====================================================================
-- vim.o.expandtab = true -- Convert tabs to spaces
-- vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
-- vim.o.tabstop = 2 -- Show tab as this number of spaces
vim.o.softtabstop = 2
vim.o.scrolloff = 8

-- Built-in completion
vim.o.complete = '.,w,b,kspell' -- Use less sources
vim.o.completetimeout = 100 -- Limit sources delay

-- Autocommands ===============================================================
-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
local f = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end
Config.new_autocmd('FileType', nil, f, "Proper 'formatoptions'")

-- Diagnostics ================================================================
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
    priority = 9999,
  },

  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },

  -- show more severe messages before less
  severity_sort = true,
  -- Don't update diagnostics when typing
  update_in_insert = false,
}

Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
