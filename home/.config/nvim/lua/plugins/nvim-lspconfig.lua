return {
  "neovim/nvim-lspconfig",
  event = "BufRead",
  cmd = { "Mason" },
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    { "williamboman/mason-lspconfig.nvim", opts = {} },
  },
  init = function()
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    -- Ref:
    -- https://neovim.io/doc/user/diagnostic.html
    -- local filled_circle = " "
    for _, type in ipairs({ "Error", "Warn", "Hint", "Info" }) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, {
        text = "",
        texthl = hl,
        numhl = hl,
      })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(args)
        local bufnr = args.buf
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
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")

        nmap("]d", vim.diagnostic.goto_next, "Jump to next diagnostic")
        nmap("[d", vim.diagnostic.goto_prev, "Jump to prev diagnostic")
        nmap("<leader>qf", vim.diagnostic.setqflist, "Set qflist")
      end,
    })
  end,
  config = function()
    local lspconfig = require("lspconfig")

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({})
      end,
    })
  end,
}
