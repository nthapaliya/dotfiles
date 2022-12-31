return function()
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
end
