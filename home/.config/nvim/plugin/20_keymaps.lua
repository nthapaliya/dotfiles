local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc }) end
local usrcmd = function(command, fn) vim.api.nvim_create_user_command(command, fn, {}) end

-- some useful keymaps
map('n', '[p', '<Cmd>exe "iput! " . v:register<CR>', 'Paste Above')
map('n', ']p', '<Cmd>exe "iput "  . v:register<CR>', 'Paste Below')

-- jk forever
map('i', 'jk', '<esc>')

-- Clear hl search with <esc>
map('n', '<esc>', '<cmd>noh<cr><esc>', 'Escape and clear hlsearch')

-- Don't enter ex-mode and command history mode respectively
map('n', 'Q', '<nop>')
map('n', 'q:', '<nop>')

-- Easily jump to next or previous buffer
map('n', '<C-p>', '<cmd>bprev<cr>', 'Previous Buffer')
map('n', '<C-n>', '<cmd>bnext<cr>', 'Next Buffer')

-- vim.pack wrappers
usrcmd('PackUpdate', function() vim.pack.update() end)
usrcmd(
  'PackSync',
  function() vim.pack.update(nil, { target = 'lockfile', force = true }) end
)
usrcmd('PackClean', function()
  local unused = vim
    .iter(vim.pack.get())
    :filter(function(x) return not x.active end)
    :map(function(x) return x.spec.name end)
    :totable()

  vim.pack.del(unused)
end)
