-- Notes: maybe add back in the future:
-- - mini.snippets
-- - mini.hipatterns

-- load first
Config.now(function()
  -- basics
  require('mini.basics').setup()

  -- icons
  require('mini.icons').setup()
  Config.later(MiniIcons.tweak_lsp_kind)

  -- tabline and statusline
  require('mini.statusline').setup()
  require('mini.tabline').setup({
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and ' ' or ''
      return MiniTabline.default_format(buf_id, label) .. suffix
    end,
  })

  -- notify
  require('mini.notify').setup({
    window = { config = { anchor = 'SE', row = vim.o.lines - 4 } },
  })
end)

-- completion
Config.later(function()
  -- Customize post-processing of LSP responses for a better user experience.
  -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  require('mini.completion').setup({
    lsp_completion = {
      -- Without this config autocompletion is set up through `:h 'completefunc'`.
      -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
      -- (sets up only when needed) and makes it possible to use `<C-u>`.
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = process_items,
    },
  })

  -- Set 'omnifunc' for LSP completion only when needed.
  local on_attach = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end
  Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

-- use default of <leader>ef and <leader>ed
Config.now_if_args(function()
  require('mini.files').setup()

  -- Yank in register full path of entry under cursor
  Config.new_autocmd('User', 'MiniFilesBufferCreate', function(args)
    local b = args.data.buf_id
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.setreg(vim.v.register, path)
      MiniFiles.close()
    end
    vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
  end, '')
end)

-- Miscellaneous small but useful functions
Config.later(function()
  -- Makes `:h MiniMisc.put()` and `:h MiniMisc.put_text()` public
  require('mini.misc').setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_termbg_sync()
end)

-- Step two ===================================================================
Config.later(function() require('mini.extra').setup() end)
Config.later(function() require('mini.ai').setup() end)
Config.later(function() require('mini.bufremove').setup() end)
Config.later(function() require('mini.comment').setup() end)
Config.later(function() require('mini.sessions').setup() end)
Config.later(function() require('mini.splitjoin').setup() end)
Config.later(function() require('mini.surround').setup() end)

Config.later(function()
  require('mini.git').setup()

  local usrcmd = function(command, fn) vim.api.nvim_create_user_command(command, fn, {}) end
  usrcmd('Gwrite', 'Git add %')
  usrcmd('Gcommit', 'Git commit')
end)

Config.later(function()
  local win_config = function()
    local height = math.floor(0.618 * vim.o.lines)
    local width = math.floor(0.618 * vim.o.columns)
    return {
      anchor = 'NW',
      height = height,
      width = width,
      row = math.floor(0.5 * (vim.o.lines - height)),
      col = math.floor(0.5 * (vim.o.columns - width)),
    }
  end
  require('mini.pick').setup({ window = { config = win_config } })
end)

Config.later(
  function()
    require('mini.align').setup({
      mappings = { start = 'gl', start_with_preview = 'gL' },
    })
  end
)

Config.later(function()
  local miniclue = require('mini.clue')
  -- stylua: ignore
  miniclue.setup({
    -- Define which clues to show. By default shows only clues for custom mappings
    -- (uses `desc` field from the mapping; takes precedence over custom clue).
    clues = {
      -- This is defined in 'plugin/20_keymaps.lua' with Leader group descriptions
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.z(),
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode =   'n',        keys = '\\' },       -- mini.basics
      { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
      { mode = { 'n', 'x' }, keys = ']' },
      { mode =   'i',        keys = '<C-x>' },    -- Built-in completion
      { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
      { mode = { 'n', 'x' }, keys = "'" },        -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },        -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode =   'n',        keys = '<C-w>' },    -- Window commands
      { mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
      { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
    },
  })
end)

Config.later(function()
  require('mini.diff').setup({
    view = {
      style = 'sign',
      -- signs = { add = '🭵', change = '🭵', delete = '🭵' },
      signs = { add = '┃', change = '┃', delete = '┃' },
    },
    options = { wrap_goto = true },
    mappings = {
      apply = '',
      reset = '',
      textoperator = '',
      textobject = '',
      goto_first = '',
      goto_prev = '',
      goto_last = '',
      goto_next = '',
    },
  })

  -- mini.diff hunk operations
  local map_hunk_operations = function(lhs, operator)
    local texobj = '<Cmd>lua MiniDiff.textobject()<CR><ESC>'
    local rhs = function() return MiniDiff.operator(operator) .. texobj end
    local desc = { desc = 'Hunk ' .. operator, expr = true, remap = true }
    vim.keymap.set({ 'n', 'x' }, lhs, rhs, desc)
  end
  map_hunk_operations('<leader>hs', 'apply')
  map_hunk_operations('<leader>hu', 'reset')
  map_hunk_operations('<leader>hy', 'yank')

  -- mini.diff movement wrapper
  -- default behavior is to error when using the keymaps
  -- in a non git file. This wraps to silently ignore
  -- the keymap instead.
  local goto_hunk = function(direction)
    return function()
      if MiniDiff.get_buf_data() == nil then return end
      MiniDiff.goto_hunk(direction)
    end
  end

  local nmap = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { desc = desc }) end
  nmap('[C', goto_hunk('first'), 'First hunk')
  nmap('[c', goto_hunk('prev'), 'Previous hunk')
  nmap(']c', goto_hunk('next'), 'Next hunk')
  nmap(']C', goto_hunk('last'), 'Last hunk')
end)

Config.later(function()
  require('mini.indentscope').setup({ symbol = '│' })
  vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'LineNr' })
end)
