return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  -- event = "BufRead",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-context", opts = {} },
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "fish",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "ruby",
        "shell",
      },
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  build = ":TSUpdate",
  opts = {},
}
