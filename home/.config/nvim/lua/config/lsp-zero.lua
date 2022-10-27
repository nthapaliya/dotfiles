return function()
  local lsp = require("lsp-zero")
  lsp.preset("recommended")

  lsp.setup()
end
