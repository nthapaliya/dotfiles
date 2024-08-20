return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      fish = { "fish_indent", "shellcheck" },
      go = { "goimports" },
      java = { "google-java-format" },
      json = { "jq" },
      lua = { "stylua" },
      ruby = { "rubyfmt" },
      rust = { "rustfmt" },
      ["*"] = { "trim_newlines", "trim_whitespace" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { timeout_ms = 500 },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
