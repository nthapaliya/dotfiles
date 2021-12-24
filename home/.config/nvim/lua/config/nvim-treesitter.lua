return function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.org = {
    install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "f110024d539e676f25b72b7c80b0fd43c34264ef",
      files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "org",
  }

  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    indent = { enable = true },
    highlight = {
      enable = true,
      disable = { "org" },
      additional_vim_regex_highlighting = { "org" },
    },
  })

  vim.o.foldlevel = 20
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
end
