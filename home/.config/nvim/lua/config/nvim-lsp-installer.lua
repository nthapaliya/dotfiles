return function()
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

  local servers = {
    "bashls",
    "eslint",
    "rust_analyzer",
    "solargraph",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "vimls",
  }

  local lsp_installer = require("nvim-lsp-installer")

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found and not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end

  lsp_installer.on_server_ready(function(server)
    local default_opts = {
      on_attach = require("config/lsp_on_attach").on_attach,
      flags = {
        debounce_text_changes = 250,
      },
    }

    local server_opts = {
      ["tsserver"] = function()
        default_opts.on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
          require("config/lsp_on_attach").on_attach(client, bufnr)
        end
      end,
      ["sumneko_lua"] = function()
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        default_opts.settings = {
          Lua = {
            runtime = { version = "LuaJIT", path = runtime_path },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        }
      end,
    }

    local server_options = server_opts[server.name] and server_opts[server.name]() or default_opts
    server:setup(require("coq").lsp_ensure_capabilities(server_options))
  end)
end
