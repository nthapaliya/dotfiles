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
      typescriptreact = {
        function()
          return {
            exe = "prettier",
            args = {
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
              "--single-quote",
            },
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
    },
  })
end
