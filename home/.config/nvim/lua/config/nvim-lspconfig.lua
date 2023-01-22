return function()
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- Ref:
  -- https://neovim.io/doc/user/diagnostic.html
  local filled = ""
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, _icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = filled, texthl = hl, numhl = hl })
  end

  require("mason").setup()

  require("mason-lspconfig").setup({
    ensure_installed = {
      "rust_analyzer",
      "solargraph",
      "sumneko_lua",
    },
  })

  require("neodev").setup()
  require("lsp-format").setup()
  require("fidget").setup()

  local on_attach = function(client, bufnr)
    require("lsp-format").on_attach(client)

    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    -- Most of this function is copied from
    -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L291
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    nmap("<leader>j", vim.diagnostic.goto_next, "Jump to next diagnostic")
    nmap("<leader>k", vim.diagnostic.goto_prev, "Jump to prev diagnostic")
  end

  local lspconfig = require("lspconfig")

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
      })
    end,
  })
end
