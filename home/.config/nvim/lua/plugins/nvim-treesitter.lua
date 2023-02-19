-- treesitter
-- slow
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    dependencies = { "andymass/vim-matchup" },
    build = ":TSUpdate",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "fish",
          "lua",
          "ruby",
          "rust",
          "vim",
        },
        indent = { enable = true },
        highlight = { enable = true },
        -- TODO: check this out, remove if I don't end up using it much
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- Third party mods
        matchup = { enable = true },
      })
    end,
  },

  -- TODO: style this so the popup is visually distinct
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    config = function()
      require("treesitter-context").setup()
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufRead",
    init = function()
      vim.o.foldcolumn = "0" -- TODO: Set to "1" with nvim 0.9
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    config = function()
      require("ufo").setup({
        --                  function(bufnr, filetype, buftype)
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO: Open all Folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO: Close all Folds" })
      vim.keymap.set(
        "n",
        "zK",
        require("ufo").peekFoldedLinesUnderCursor,
        { desc = "UFO: Peek Folded Lines Under Cursor" }
      )
      vim.keymap.set("n", "[f", require("ufo").goPreviousClosedFold, { desc = "UFO: Go to previous closed fold" })
      vim.keymap.set("n", "]f", require("ufo").goNextClosedFold, { desc = "UFO: Go to next closed fold" })
    end,
  },
}
