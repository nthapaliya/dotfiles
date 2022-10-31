return function()
  local lsp = require("lsp-zero")
  lsp.preset("recommended")
  lsp.ensure_installed({
    "tsserver",
    "eslint",
    "sumneko_lua",
  })
  lsp.configure("sumneko_lua", {
    -- Get the language server to recognize the `vim` global
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
  })

  lsp.setup()
end
