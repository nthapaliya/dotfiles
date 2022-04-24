-- packer bootstrap: install to opt
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local status, _ = pcall(require, "packer_compiled")
if status then
  -- If there are cache issues, comment this out, as well as
  -- the `compile_path` line in plugins.lua, and rerun :PackerCompile
  require("impatient").enable_profile()
  -- require("packer_compiled")
else
  vim.cmd("packadd packer.nvim")
  require("plugins").sync()
end

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
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- Keymaps
vim.keymap.set("n", "<leader>W", [[:%s/\s\+$<cr>]])
vim.keymap.set("n", "<leader>ev", ":execute 'e ' . resolve(expand($MYVIMRC))<cr>")
vim.keymap.set("n", "<leader>d", ":cd ~/Projects/dotfiles<cr>")
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>")
vim.keymap.set("n", "<Left>", ":BufPrev<cr>")
vim.keymap.set("n", "<Right>", ":BufNext<cr>")
vim.keymap.set("c", "w!!", "w !sudo tee % >/dev/null")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "<leader>q", ":Bdelete<cr>")

-- Don't enter ex-mode and command history mode respectively
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ "n", "v" }, "q:", "<nop>")

-- Plugins
-- Fzf.vim
vim.keymap.set("n", "<c-t>", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>g", ":FzfLua git_status<cr>")
vim.keymap.set("n", "<leader>b", ":FzfLua buffers<cr>")
-- vim.keymap.set("n", "<leader>*", ":FzfLua files<cr>")

-- Trouble
vim.keymap.set("n", "<leader>tt", ":TroubleToggle<cr>")

-- Autocmds
local autocmds = {
  on_save = {
    { event = "BufWritePost", pattern = "*/nvim/init.lua", command = "source $MYVIMRC" },
    {
      event = "BufWritePost",
      pattern = { "*/nvim/lua/config/*.lua", "*/nvim/lua/plugins.lua" },
      command = "source <afile> | PackerCompile",
    },
  },

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
    {
      event = "TextYankPost",
      pattern = "*",
      callback = function()
        vim.highlight.on_yank()
      end,
    },
  },

  trimtrailingwhitespace = {
    { event = "BufWritePre", pattern = "*", command = [[%s/\s\+$//e]] },
    { event = "BufWritePre", pattern = "*", command = [[%s/\n\+\%$//e]] },
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
  },

  oscyank = {
    {
      event = "TextYankPost",
      pattern = "*",
      callback = function()
        local is_ssh = string.len(vim.env.SSH_CLIENT or "") > 0
        local event = vim.api.nvim_get_vvar("event")
        if is_ssh and event.operator == "y" and event.regname == "" then
          vim.cmd('OSCYankReg "')
        end
        -- print(vim.inspect(arguments))
        -- [[if $SSH_CLIENT != '' && v:event.operator is 'y' && v:event.regname is '' | ]],
        -- [[execute 'OSCYankReg "' | ]],
        -- [[endif]],
      end,
    },
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
vim.api.nvim_create_user_command("PackerInstall", "packadd packer.nvim | lua require('plugins').install()", {})
vim.api.nvim_create_user_command("PackerUpdate", "packadd packer.nvim  | lua require('plugins').update()", {})
vim.api.nvim_create_user_command("PackerSync", "packadd packer.nvim    | lua require('plugins').sync()", {})
vim.api.nvim_create_user_command("PackerClean", "packadd packer.nvim   | lua require('plugins').clean()", {})
vim.api.nvim_create_user_command("PackerCompile", "packadd packer.nvim | lua require('plugins').compile()", {})

vim.keymap.set("n", "gx", function()
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

-- vim.g.oscyank_silent = true

-- -- Rewrite these in lua
-- vim.cmd([[
-- command! Today execute 'normal Go<esc>'    | r!date "+\%F (\%a \%b \%d)"
-- command! -nargs=* Now execute 'normal G'   | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
-- ]])
