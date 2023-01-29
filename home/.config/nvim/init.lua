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
vim.g.mapleader = " "

-- Globals
require('keymaps')
require('opts')

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
    {
      event = "TermOpen",
      pattern = "term://*",
      callback = function()
        vim.cmd [[setlocal nonumber norelativenumber]]
        vim.cmd [[startinsert]]
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
vim.cmd [[nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]]

-- -- Rewrite these in lua
-- vim.cmd([[
-- command! Today execute 'normal Go<esc>'    | r!date "+\%F (\%a \%b \%d)"
-- command! -nargs=* Now execute 'normal G'   | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
-- ]])

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
