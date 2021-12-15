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
  end

  vim.diagnostic.config({
    severity_sort = true,
    underline = false,
    update_in_insert = false,
    virtual_text = false,
  })

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local completionItem = capabilities.textDocument.completion.completionItem
    completionItem.snippetSupport = true
    completionItem.preselectSupport = true
    completionItem.insertReplaceSupport = true
    completionItem.labelDetailsSupport = true
    completionItem.deprecatedSupport = true
    completionItem.commitCharactersSupport = true
    completionItem.tagSupport = { valueSet = { 1 } }
    completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }

    local opts = {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 250,
        capabilities = capabilities,
      },
    }

    if server.name == "tsserver" then
      opts.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        on_attach(client, bufnr)
      end
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
