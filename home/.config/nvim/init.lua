-- packer bootstrap: install to opt
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- If there are cache issues, comment this out, as well as
-- the `compile_path` line in plugins.lua, and rerun :PackerCompile
require("impatient").enable_profile()
require("packer_compiled")

-- This will never need to be uncommented as long as we don't forget :PackerCompile
-- require('plugins')

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  "gzip",
  "matchit",
  "matchparen",
  -- "shada_plugin",
  "tarPlugin",
  "tar",
  "zipPlugin",
  "zip",
  "netrwPlugin",
}

for _, name in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. name] = 1
end

-- Settings
vim.opt.breakindent = true
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.lazyredraw = true

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.shell = "bash"
vim.opt.shortmess:append("c")
vim.opt.showbreak = [[\\\\\]]
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.synmaxcol = 300
vim.opt.title = true
vim.opt.updatetime = 100
vim.opt.visualbell = true

vim.opt.list = true
vim.opt.listchars = { extends = "#", nbsp = "·", tab = "▸·", trail = "·" }

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Globals
vim.g.mapleader = " "
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- Remaps
local remap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

remap("n", "<leader>W", [[:%s/\s\+$<cr>]], opts)
remap("n", "<leader>ev", [[:execute 'e ' . resolve(expand($MYVIMRC))<cr>]], opts)
remap("n", "<leader>sv", [[:source $MYVIMRC<cr>]], opts)
remap("n", "<Left>", [[:bprev<cr>]], opts)
remap("n", "<Right>", [[:bnext<cr>]], opts)
remap("c", "w!!", [[w !sudo tee % >/dev/null]], {})
remap("i", "jk", [[<esc>]], opts)

-- Don't enter ex-mode and command history mode respectively
remap("n", "Q", [[<nop>]], opts)
remap("n", "q:", [[<nop>]], opts)
remap("v", "q:", [[<nop>]], opts)

-- Plugins
-- Telescope
remap("n", "<c-p>", [[:Telescope find_files<cr>]], opts)
remap("n", "<leader>tb", [[:Telescope buffers<cr>]], opts)
remap("n", "<leader>te", [[:Telescope file_browser<cr>]], opts)
remap("n", "<leader>tg", [[:Telescope git_status<cr>]], opts)
remap("n", "<leader>to", [[:Telescope oldfiles<cr>]], opts)
remap("n", "<leader>*", [[:Telescope grep_string<cr>]], opts)
-- remap("n", "<leader>*", [[*N"zyiw:Rg <c-r>z<cr>]], opts)

-- Trouble
remap("n", "<leader>tt", [[:TroubleToggle<cr>]], opts)

-- Terminal stuff, not sure I ever used these
remap("t", "<Esc>", [[<C-\><C-n>]], opts)
remap("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
remap("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
remap("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
remap("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

-- Autocmds
local autocmds = {
  on_save = {
    { "BufWritePost", "plugins.lua", [[source <afile> | PackerCompile]] },
    { "BufWritePost", "*/nvim/lua/config/*.lua", [[source <afile> | PackerCompile]] },
    { "BufWritePost", [[$MYVIMRC]], "nested", "source", [[$MYVIMRC]] },
    { "BufWritePost", [[*.tsx,*.json,*.lua,*.fish]], "FormatWrite" },
  },
  filetype = {
    -- { "FileType", "vim", "setlocal foldmethod=marker" },
    { "FileType", "diff", [[setlocal commentstring=#\ %s']] },
    { "FileType", "gitcommit", [[setlocal spell commentstring=#\ %s textwidth=80']] },
    { "FileType", "text", [[setlocal spell commentstring=#\ %s textwidth=80']] },
    { "FileType", "markdown", "setlocal tabstop=4 sts=4 sw=4 expandtab" },
    { "FileType", "ruby", "nnoremap <F5> :!time ruby %<cr>" },
    { "FileType", "rust", "nnoremap <F5> :!cargo run<cr>" },
  },
  general = {
    { "VimResized", "*", "wincmd =" },
    { "TextYankPost", "*", "silent!", "lua vim.highlight.on_yank()" },
  },
  trimtrailingwhitespace = {
    { "BufWritePre", "*", [[%s/\s\+$//e]] },
    { "BufWritePre", "*", [[%s/\n\+\%$//e]] },
  },
}

require("nvim_utils")
nvim_create_augroups(autocmds)

-- Commands
vim.cmd([[
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
command! PackerInstall packadd packer.nvim | lua require('plugins').install()
command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
command! PackerSync packadd packer.nvim | lua require('plugins').sync()
command! PackerClean packadd packer.nvim | lua require('plugins').clean()
command! PackerCompile packadd packer.nvim | lua require('plugins').compile()
]])
