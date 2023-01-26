local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

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

-- Keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>W", [[:%s/\s\+$<cr>]])
vim.keymap.set("n", "<leader>ev", ":execute 'e ' . resolve(expand($MYVIMRC))<cr>")
vim.keymap.set("n", "<leader>d", ":cd ~/Projects/dotfiles<cr>")
vim.keymap.set("n", "<Left>", ":bp<cr>")
vim.keymap.set("n", "<Right>", ":bn<cr>")
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null")
vim.keymap.set("i", "jk", "<esc>")
-- vim.keymap.set("n", "<leader>ep", ":execute 'e ' . resolve(expand($MYVIMRC))<cr>")
-- vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Don't enter ex-mode and command history mode respectively
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ "n", "v" }, "q:", "<nop>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- https://github.com/mhinz/vim-galore#quickly-move-current-line
-- https://github.com/mhinz/vim-galore#quickly-add-empty-lines
vim.keymap.set("n", "[e", ":<c-u>execute 'move -1-'. v:count1<cr>", { silent = true })
vim.keymap.set("n", "]e", ":<c-u>execute 'move +'. v:count1<cr>", { silent = true })
vim.keymap.set("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>", { silent = true })
vim.keymap.set("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>", { silent = true })

require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Autocmds
local autocmds = {
  -- on_save = {
  --   -- redundant while we have Formatter plugin
  --   { event = "BufWritePre", pattern = "", command = ":%s/\\s\\+$//e" },
  -- },

  filetype = {
    { event = "FileType", pattern = "diff", command = [[setlocal commentstring=#\ %s]] },
    { event = "FileType", pattern = "gitcommit", command = [[setlocal spell commentstring=#\ %s textwidth=80]] },
    { event = "FileType", pattern = "markdown", command = "setlocal tabstop=4 sts=4 sw=4 expandtab" },
    { event = "FileType", pattern = "ruby", command = "nnoremap <F5> :!time ruby %<cr>" },
    { event = "FileType", pattern = "rust", command = "nnoremap <F5> :!cargo run<cr>" },
    { event = "FileType", pattern = "text", command = [[setlocal spell commentstring=#\ %s textwidth=80]] },
  },

  general = {
    { event = "VimResized", pattern = "*", command = "wincmd =" },
    -- Don't auto comment new lines
    -- { event = "BufEnter", pattern = "", command = "set fo-=c fo-=r fo-=o" },
  },

  terminal = {
    { event = "TermOpen", pattern = "term://*", command = "setlocal nonumber norelativenumber" },
    { event = "TermOpen", pattern = "term://*", command = "startinsert" },
    {
      event = "TermOpen",
      pattern = "term://*",
      callback = function()
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
        vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
        vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
        vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
        vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])
      end,
    },
    {
      event = { "BufWinEnter", "WinEnter" },
      pattern = "term://*",
      command = "startinsert",
    },
    { event = "BufLeave", pattern = "term://*", command = "stopinsert" },
  },
}

for group_name, definitions in pairs(autocmds) do
  local group_id = vim.api.nvim_create_augroup(group_name, { clear = true })
  for _, definition in ipairs(definitions) do
    local autocmd_event = definition.event
    definition.event = nil
    definition.group = group_id
    vim.api.nvim_create_autocmd(autocmd_event, definition)
  end
end

-- Commands
vim.keymap.set("n", "gx", function()
  -- test: "nthapaliya/dotfiles"
  local open = function(url)
    vim.cmd("silent! !open " .. vim.fn.shellescape(url, 1) .. ">&/dev/null")
  end

  -- try for Plug/Packer style 'urls': aka "username/repo"
  if vim.bo.filetype == "lua" then
    local word = vim.fn.expand("<cWORD>")
    local matcher = '"(%S+/%S+)"'
    local match = string.match(word, matcher)

    if match ~= nil then
      local github_url = "https://github.com/" .. match
      open(github_url)
      return
    end
  end

  open(vim.fn.expand("<cfile>"))
end)

-- -- Rewrite these in lua
-- vim.cmd([[
-- command! Today execute 'normal Go<esc>'    | r!date "+\%F (\%a \%b \%d)"
-- command! -nargs=* Now execute 'normal G'   | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
-- ]])
