-- Copied from LazyVim configs
-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local telescope = function(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts

    opts = vim.tbl_deep_extend("force", { cwd = require("mini.misc").find_root() or vim.loop.cwd() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat(opts.cwd .. "/.git") then
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
    "junegunn/fzf",
    dependencies = { "junegunn/fzf.vim" },
    enabled = false,
    keys = {
      { "<C-t>", "<cmd>Files<cr>" },
      { "<leader>fb", "<cmd>Buffers<cr>" },
      { "<leader>fg", "<cmd>GFiles?<cr>" },
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
    opts = function()
      local find_command
      if vim.env.FZF_DEFAULT_COMMAND then
        find_command = vim.split(vim.env.FZF_DEFAULT_COMMAND, " ", { plain = true })
      end

      require("telescope")
      local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")

      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<C-u>"] = false,
            },
          },
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = find_command,
          },
        },
      }
    end,
    cmd = { "Telescope" },
    keys = {
      { "<C-t>", telescope("files"), desc = "Telescope find files" },
      { "<leader>*", telescope("grep_string"), desc = "Telescope grep_string" },
      { "<leader>fb", telescope("buffers"), desc = "Telescope buffers" },
      { "<leader>fg", telescope("git_status"), desc = "Telescope git status" },
    },
  },
}
