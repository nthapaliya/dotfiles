-- Copied from LazyVim configs
-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local telescope = function(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts

    opts = vim.tbl_deep_extend("force", { cwd = require("mini.misc").find_root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

-- slow
return {
  -- fuzzy finders
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    enabled = false,
    keys = {
      { "<C-t>", "<cmd>Files<cr>" },
      { "<leader>g", "<cmd>GFiles?<cr>" },
      { "<leader>b", "<cmd>Buffers<cr>" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Rg", function(opts)
        telescope("grep_string", { search = opts.args })()
      end, { nargs = "*" })
    end,
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
      },
      pickers = {
        find_files = {
          find_command = vim.split(vim.env.FZF_CTRL_T_COMMAND, " ", { plain = true }),
        },
      },
    },
    cmd = { "Telescope" },
    keys = {
      { "<leader>*", telescope("grep_string"), desc = "Telescope grep_string" },
      { "<C-t>", telescope("files"), desc = "Telescope find files" },
      { "<leader>fg", telescope("git_status"), desc = "Telescope git status" },
      { "<leader>fb", telescope("buffers"), desc = "Telescope buffers" },
    },
  },
}
