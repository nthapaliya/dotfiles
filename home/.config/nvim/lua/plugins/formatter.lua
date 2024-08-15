-- slow

return {
  "mhartington/formatter.nvim",
  cmd = { "FormatWrite" },
  init = function()
    local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
    local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

    autocmd("BufWritePost", {
      group = augroup("SetFormatWrite", { clear = true }),
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
        ruby = { require("formatter.filetypes.ruby").rubocop },
        java = {
          function()
            return {
              exe = "java",
              args = { "-jar", os.getenv("HOME") .. "/.local/jar/google-java-format-1.22.0-all-deps.jar", "-" },
              stdin = true,
            }
          end,
        },
        go = { require("go.format").goimports },
        ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
      },
    })
  end,
}
