-- slow
return {
  "mhartington/formatter.nvim",
  cmd = { "FormatWrite" },
  init = function()
    local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
    local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
    augroup("setFormatWrite", { clear = true })
    autocmd("BufWritePost", {
      group = "setFormatWrite",
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
