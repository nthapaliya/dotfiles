local opts = {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "git: jump to next git hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "git: jump to prev git hunk" })

    -- Actions
    map("n", "<leader>hS", gs.stage_buffer, { desc = "git: stage hunk" })
    map("n", "<leader>hU", gs.reset_buffer, { desc = "git: reset buffer" })
    map({ "n", "v" }, "<leader>hs", gs.stage_hunk, { desc = "git: stage hunk" })
    map({ "n", "v" }, "<leader>hu", gs.reset_hunk, { desc = "git: reset hunk" })
    map({ "n", "v" }, "<leader>hr", gs.undo_stage_hunk, { desc = "git: undo stage hunk" })
  end,
}

-- slow
return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = opts,
}
