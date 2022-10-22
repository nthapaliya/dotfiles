return function()
  require("formatter").setup({
    filetype = {
      json = {
        function()
          return {
            exe = "jq",
            args = { "." },
            stdin = true,
          }
        end,
      },
      fish = {
        function()
          return {
            exe = "fish_indent",
            stdin = true,
          }
        end,
      },
      lua = {
        function()
          return {
            exe = "stylua",
            args = { "--indent-type", "Spaces", "--indent-width", 2, "-" },
            stdin = true,
          }
        end,
      },
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace,
      },
    },
  })
end
