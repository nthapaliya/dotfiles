-- General ====================================================================
vim.g.mapleader = ' '
vim.o.shada = '' -- Limit ShaDa file (for startup)
vim.o.switchbuf = 'usetab' -- Use already opened buffers when switching
vim.o.clipboard = 'unnamedplus'
-- vim.o.undofile = false

-- stylua: ignore start
-- UI =========================================================================
vim.o.list          = true
vim.o.fillchars     = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.listchars     = 'extends:#,nbsp:·,tab:▸·,trail:·'
vim.o.pumborder     = 'rounded' -- Use border in popup menu
vim.o.winborder     = 'rounded' -- Use border in floating windows
vim.o.pummaxwidth   = 100       -- Make popup menu not too wide
vim.o.cursorline    = true
vim.o.termguicolors = true

vim.o.foldlevel  = 99
vim.o.foldmethod = 'indent' -- Fold based on indent level
vim.o.foldtext   = ''       -- Show text under fold with its highlighting

-- Editing ====================================================================
vim.o.expandtab   = true -- Convert tabs to spaces
vim.o.tabstop     = 2    -- Show tab as this number of spaces
vim.o.shiftwidth  = 0    -- If set to zero, uses value of tabstop
vim.o.softtabstop = -1   -- If set to -1, uses value of shiftwidth
vim.o.scrolloff   = 12
vim.o.smartindent = true
vim.o.synmaxcol   = 300

-- Built-in completion
vim.o.complete        = '.,w,b,kspell' -- Use less sources
vim.o.completetimeout = 100            -- Limit sources delay
-- stylua: ignore end

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
      [vim.diagnostic.severity.ERROR] = '!!',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
    },
    severity = {
      min = vim.diagnostic.severity.INFO,
    },
    priority = 9999,
  },

  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
  },

  -- show more severe messages before less
  severity_sort = true,
  -- Don't update diagnostics when typing
  update_in_insert = false,
}

Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
