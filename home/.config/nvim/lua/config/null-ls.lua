return function()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      -- null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.formatting.trim_newlines,
      -- null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.rustywind,
      null_ls.builtins.formatting.stylua.with({
        args = { "--indent-type", "Spaces", "--indent-width", 2, "-" },
      }),

      null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.diagnostics.rubocop,
      null_ls.builtins.diagnostics.shellcheck,
      -- null_ls.builtins.diagnostics.proselint,
      -- null_ls.builtins.diagnostics.write_good,
    },
    on_attach = function(client, bufnr)
      if client.resolved_capabilities.document_formatting then
        local formatter_group = vim.api.nvim_create_augroup("Formatting", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function()
            vim.lsp.buf.formatting_sync()
          end,
          group = formatter_group,
          pattern = "<buffer>",
        })
      end
      require("config/lsp_on_attach").on_attach(client, bufnr)
    end,
  })
end
