return function()
  require("formatter").setup({
    filetype = {
      fish = { require("formatter.filetypes.fish").fishindent },
      json = { require("formatter.filetypes.json").jq },
      lua = { require("formatter.filetypes.lua").stylua },
      ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
    },
  })
end
