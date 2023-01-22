M = {}

M.gitsigns_opts = {
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
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hU", gs.reset_buffer)
    map({ "n", "v" }, "<leader>hs", gs.stage_hunk)
    map({ "n", "v" }, "<leader>hu", gs.reset_hunk)
    map({ "n", "v" }, "<leader>hr", gs.undo_stage_hunk)
  end,
}

-- slow
return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = M.gitsigns_opts,
}
