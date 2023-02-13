-- slow

M.on_attach(function(client, bufnr)
  if client.server_capabilities["documentFormattingProvider"] then
    local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
    local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

    autocmd("BufWritePre", {
      group = augroup("setFormatWrite2", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          filter = function(clnt)
            return clnt.name ~= "lua_ls"
          end,
        })
      end,
    })
  end
end)

return {
  "mhartington/formatter.nvim",
  cmd = { "FormatWrite" },
  init = function()
    local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
    local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

    autocmd("BufWritePost", {
      group = augroup("setFormatWrite", { clear = true }),
      pattern = "*",
      command = "FormatWrite",
    })
  end,
  config = function()
    require("formatter").setup({
      filetype = {
        fish = { require("formatter.filetypes.fish").fishindent },
        json = { require("formatter.filetypes.json").jq },
        lua = { require("formatter.filetypes.lua").stylua },
        javascript = { require("formatter.filetypes.javascript").prettier },
        rust = { require("formatter.filetypes.rust").rustfmt },
        ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
      },
    })
  end,
}
