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
require("keymaps")
require("opts")
require("autocmds")

-- Commands
vim.cmd([[nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]])

-- -- Rewrite these in lua
vim.cmd([[
command! Today execute 'normal Go<esc>'    | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G'   | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
]])

require("lazy").setup("plugins", {
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "catppuccin", "habamax" } },
  -- checker = { enabled = true, notify = false },
  change_detection = { enabled = false, notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrw",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
