return function()
  -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts) -- this!!
    buf_set_keymap("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- TODO: null-ls setup
    -- we'd have to disable 'Formatter' first
    -- if client.resolved_capabilities.document_formatting then
    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    -- end

    vim.cmd([[
          augroup Hover
            autocmd!
            autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false})
          augroup end
          ]])
  end

  -- copied blob from:
  -- https://github.com/hrsh7th/cmp-nvim-lsp/blob/246a41c55668d5f84afcd805ee73b6e419375ae0/lua/cmp_nvim_lsp/init.lua#L18-L44
  local update_capabilities = function(capabilities, override)
    local if_nil = function(val, default)
      if val == nil then
        return default
      end
      return val
    end

    override = override or {}

    local completionItem = capabilities.textDocument.completion.completionItem

    completionItem.snippetSupport = if_nil(override.snippetSupport, true)
    completionItem.preselectSupport = if_nil(override.preselectSupport, true)
    completionItem.insertReplaceSupport = if_nil(override.insertReplaceSupport, true)
    completionItem.labelDetailsSupport = if_nil(override.labelDetailsSupport, true)
    completionItem.deprecatedSupport = if_nil(override.deprecatedSupport, true)
    completionItem.commitCharactersSupport = if_nil(override.commitCharactersSupport, true)
    completionItem.tagSupport = if_nil(override.tagSupport, { valueSet = { 1 } })
    completionItem.resolveSupport = if_nil(override.resolveSupport, {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    })

    return capabilities
  end

  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    update_in_insert = false,
  })

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = update_capabilities(capabilities)

    local opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
        capabilities = capabilities,
      },
    }

    if server.name == "solargraph" then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

    if server.name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            globals = {
              "runtime_path",
              "use",
              "vim",
            },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      }
    end

    server:setup(opts)
  end)
end
