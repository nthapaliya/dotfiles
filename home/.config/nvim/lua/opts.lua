-- Settings

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.opt.expandtab = true
vim.opt.lazyredraw = true
vim.opt.scrolloff = 8
vim.opt.shell = "bash"
vim.opt.shiftwidth = 2
vim.opt.showbreak = [[\\\\\]]
vim.opt.softtabstop = 2
vim.opt.synmaxcol = 300
vim.opt.tabstop = 2
vim.opt.title = true
vim.opt.updatetime = 100
vim.opt.visualbell = true

-- Overriding mini.basics defaults
vim.opt.cursorline = false
vim.opt.undofile = false -- I'm not sure I like unlimited undo.
vim.opt.wrap = true -- Wrap = false causes the trackpad to scroll horizontally on my laptop

-- Commented out while testing mini.basic
-- vim.opt.breakindent = true
-- vim.opt.completeopt = { "menuone", "noselect" }
-- vim.opt.ignorecase = true
-- vim.opt.infercase = true
-- vim.opt.list = true
-- vim.opt.listchars = { extends = "#", nbsp = "·", tab = "▸·", trail = "·" }
-- vim.opt.mouse = "a"
-- vim.opt.number = true
-- vim.opt.shortmess:append("c")
-- vim.opt.showmode = false
-- vim.opt.signcolumn = "yes"
-- vim.opt.smartcase = true
