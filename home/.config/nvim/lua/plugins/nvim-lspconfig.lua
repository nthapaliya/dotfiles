local init = function()
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
  -- local filled_circle = ""
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
      text = icon,
      texthl = hl,
      numhl = hl,
    })
  end
end

local config = function()
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

  local lsp_attach = function(client, bufnr)
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
    -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    nmap("<leader>j", vim.diagnostic.goto_next, "Jump to next diagnostic")
    nmap("<leader>k", vim.diagnostic.goto_prev, "Jump to prev diagnostic")
  end

  local lspconfig = require("lspconfig")
  local coq = require("coq")

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      lspconfig[server_name].setup(coq.lsp_ensure_capabilities({ on_attach = lsp_attach }))
    end,
  })
end

-- lsp
-- TODO: slow
return {
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Additional plugins
      "folke/neodev.nvim",
      "j-hui/fidget.nvim",
      "lukas-reineke/lsp-format.nvim",
    },
    init = init,
    config = config,
  },

  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    dependencies = { "ms-jpq/coq.artifacts", branch = "artifacts" },
    event = "InsertEnter",
    init = function()
      vim.g.coq_settings = {
        ["keymap.jump_to_mark"] = "",
        auto_start = "shut-up",
      }
    end,
  },
}
