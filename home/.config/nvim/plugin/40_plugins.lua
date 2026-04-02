Config.now(function()
  vim.pack.add({
    { src = 'https://codeberg.org/evergarden/nvim.git', name = 'evergarden' },
  })

  require('evergarden').setup({
    style = { disable_styles = { 'italic' } },
  })
  vim.cmd.colorscheme('evergarden')
end)

Config.now(function()
  vim.pack.add({ 'https://github.com/tpope/vim-sleuth' })

  -- smart-splits.nvim
  -- keymaps in 20_keymaps.lua
  vim.pack.add({ 'https://github.com/mrjones2014/smart-splits.nvim' })
end)

-- jupytext.nvim
Config.now_if_args(function()
  vim.pack.add({
    {
      src = 'https://github.com/goerz/jupytext.nvim',
      version = vim.version.range('0.2.0'),
    },
  })

  require('jupytext').setup({ format = 'markdown' })
end)

-- experimental: activate neovim builtin undotree plugin
Config.now_if_args(function() vim.cmd('packadd nvim.undotree') end)

-- nvim-treesitter
Config.now_if_args(function()
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })
  local languages = {
    'bash',
    'fish',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'ruby',
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
    -- folds, provided by Neovim
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
  end

  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

-- nvim-lspconfig
Config.now_if_args(function()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

  vim.lsp.enable({
    'lua_ls',
    'ruff',
  })
end)

-- conform.nvim
Config.now_if_args(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
  require('conform').setup({
    formatters_by_ft = {
      fish = { 'fish_indent' },
      json = { 'jq' },
      lua = { 'stylua' },
      ruby = { 'rubyfmt' },
      python = { 'ruff_format' },
      markdown = { 'injected' },
      ['*'] = { 'trim_newlines', 'trim_whitespace' },
    },
    default_format_opts = { lsp_format = 'fallback' },
    format_on_save = { timeout_ms = 500 },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  })
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end)
