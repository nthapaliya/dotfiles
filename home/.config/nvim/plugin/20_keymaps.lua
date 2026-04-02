local nmap = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { desc = desc }) end
local vmap = function(lhs, rhs, desc) vim.keymap.set('v', lhs, rhs, { desc = desc }) end
local imap = function(lhs, rhs, desc) vim.keymap.set('i', lhs, rhs, { desc = desc }) end
local xmap = function(lhs, rhs, desc) vim.keymap.set('x', lhs, rhs, { desc = desc }) end
local usrcmd = function(command, fn) vim.api.nvim_create_user_command(command, fn, {}) end

nmap('[p', '<Cmd>exe "iput! " . v:register<CR>', 'Paste Above')
nmap(']p', '<Cmd>exe "iput "  . v:register<CR>', 'Paste Below')

Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>h', desc = '+Hunk' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

local nmap_leader = function(suffix, rhs, desc) nmap('<Leader>' .. suffix, rhs, desc) end
local xmap_leader = function(suffix, rhs, desc) xmap('<Leader>' .. suffix, rhs, desc) end

local edit_plugin_file = function(filename)
  return string.format('<Cmd>edit %s/plugin/%s<CR>', vim.fn.stdpath('config'), filename)
end
local explore_at_file =
  "<Cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0))<CR>"
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end
local explore_locations = function()
  vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen')
end

-- e is for 'Explore'
nmap_leader('ed', "<Cmd>lua require('mini.files').open()<CR>", 'Directory')
nmap_leader('ef', explore_at_file, 'File directory')
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>', 'init.lua')
nmap_leader('ek', edit_plugin_file('20_keymaps.lua'), 'Keymaps config')
nmap_leader('em', edit_plugin_file('30_mini.lua'), 'MINI config')
nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
nmap_leader('eo', edit_plugin_file('10_options.lua'), 'Options config')
nmap_leader('ep', edit_plugin_file('40_plugins.lua'), 'Plugins config')
nmap_leader('eq', explore_quickfix, 'Quickfix list')
nmap_leader('eQ', explore_locations, 'Location list')
nmap('-', '<CMD>Oil<CR>', 'Open parent directory')

-- f is for 'Find' (using fzf-lua)
nmap('<C-t>', "<Cmd>lua require('fzf-lua').files()<CR>", 'Find files')
nmap_leader('fb', "<Cmd>lua require('fzf-lua').buffers()<CR>", 'Find buffers')
nmap_leader(
  'f?',
  "<Cmd>lua require('fzf-lua').builtin()<CR>",
  'Display builtin fzf-lua pickers'
)

-- l is for 'Language'
nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostic popup')
nmap_leader('lf', '<Cmd>lua vim.lsp.buf.format()<CR>', 'Format')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation')
nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover')
nmap_leader('ll', '<Cmd>lua vim.lsp.codelens.run()<CR>', 'Lens')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Source definition')
nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

xmap_leader('lf', '<Cmd>lua vim.lsp.buf.format()<CR>', 'Format')

-- MISC FROM OLD DOTFILES
-- jk forever
imap('jk', '<esc>')

-- Clear hl search with <esc>
nmap('<esc>', '<cmd>noh<cr><esc>', 'Escape and clear hlsearch')

-- Don't enter ex-mode and command history mode respectively
nmap('Q', '<nop>')
nmap('q:', '<nop>')

-- configure smart-splits.nvim
local mmap = function(lhs, dir)
  local cmd = "<Cmd>lua require('smart-splits').move_cursor_" .. dir .. '()<CR>'
  local desc = 'SmartSplits: move cursor ' .. dir
  nmap(lhs, cmd, desc)
end
mmap('<C-h>', 'left')
mmap('<C-j>', 'down')
mmap('<C-k>', 'up')
mmap('<C-l>', 'right')

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

local map_hunk_operations = function(lhs, operator)
  local texobj = '<Cmd>lua MiniDiff.textobject()<CR>'
  local rhs = function() return require('mini.diff').operator(operator) .. texobj end
  vim.keymap.set('n', lhs, rhs, { desc = 'Hunk ' .. operator, expr = true, remap = true })
end
map_hunk_operations('<leader>hs', 'apply')
map_hunk_operations('<leader>hu', 'reset')
map_hunk_operations('<leader>hy', 'yank')
usrcmd('Gwrite', 'Git add %')
