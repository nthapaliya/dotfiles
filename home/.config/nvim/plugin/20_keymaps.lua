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
usrcmd('PackSync', function() vim.pack.update(nil, { target = 'lockfile' }) end)
usrcmd('PackClean', function()
  local unused = vim
    .iter(vim.pack.get())
    :filter(function(x) return not x.active end)
    :map(function(x) return x.spec.name end)
    :totable()

  vim.pack.del(unused)
end)

-- BufOnly
usrcmd('BufOnly', function()
  local cur_buf_id = vim.api.nvim_get_current_buf()
  local modified = function(bid)
    return vim.api.nvim_get_option_value('modified', { buf = bid })
  end
  local can_delete = function(bid) return (bid ~= cur_buf_id) and (not modified(bid)) end

  local deleted = 0
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if can_delete(buf_id) then
      deleted = deleted + 1
      vim.api.nvim_buf_delete(buf_id, {})
    end
  end
  print('BufOnly: deleted ' .. deleted .. ' buffers.')
end)
