local nmap = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { desc = desc }) end
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
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>', 'init.lua')
nmap_leader('ek', edit_plugin_file('20_keymaps.lua'), 'Keymaps config')
nmap_leader('em', edit_plugin_file('30_mini.lua'), 'MINI config')
nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
nmap_leader('eo', edit_plugin_file('10_options.lua'), 'Options config')
nmap_leader('ep', edit_plugin_file('40_plugins.lua'), 'Plugins config')
nmap_leader('eq', explore_quickfix, 'Quickfix list')
nmap_leader('eQ', explore_locations, 'Location list')
nmap('-', explore_at_file, 'File Directory')

-- f is for 'Fuzzy Find'
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

nmap('<C-t>', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('f/', '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
nmap_leader('fA', pick_added_hunks_buf, 'Added hunks (buf)')
nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
nmap_leader('fc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (buf)')
nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
nmap_leader('fH', '<Cmd>Pick hl_groups<CR>', 'Highlight groups')
nmap_leader('fl', '<Cmd>Pick buf_lines scope="all"<CR>', 'Lines (all)')
nmap_leader('fL', '<Cmd>Pick buf_lines scope="current"<CR>', 'Lines (buf)')
nmap_leader('fm', '<Cmd>Pick git_hunks<CR>', 'Modified hunks (all)')
nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>', 'Modified hunks (buf)')
nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>', 'References (LSP)')
nmap_leader('fs', pick_workspace_symbols_live, 'Symbols workspace (live)')
nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols document')
nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>', 'Visit paths (all)')
nmap_leader('fV', '<Cmd>Pick visit_paths<CR>', 'Visit paths (cwd)')

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
local move_map = function(lhs, dir)
  local cmd = "<cmd>lua require('smart-splits').move_cursor_" .. dir .. '()<CR>'
  local desc = 'SmartSplits: move cursor ' .. dir
  nmap(lhs, cmd, desc)
end
move_map('<C-h>', 'left')
move_map('<C-j>', 'down')
move_map('<C-k>', 'up')
move_map('<C-l>', 'right')

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
  local texobj = '<Cmd>lua MiniDiff.textobject()<CR><ESC>'
  local rhs = function() return require('mini.diff').operator(operator) .. texobj end
  local desc = { desc = 'Hunk ' .. operator, expr = true, remap = true }
  vim.keymap.set({ 'n', 'x' }, lhs, rhs, desc)
end
map_hunk_operations('<leader>hs', 'apply')
map_hunk_operations('<leader>hu', 'reset')
map_hunk_operations('<leader>hy', 'yank')
usrcmd('Gwrite', 'Git add %')
usrcmd('Gcommit', 'Git commit')
