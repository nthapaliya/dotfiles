-- Keymaps
local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "<leader>W", [[:%s/\s\+$<cr>]])
map("n", "<leader>ev", ":execute 'e ' . resolve(expand($MYVIMRC))<cr>")
map("n", "<leader>d", ":cd ~/Projects/dotfiles<cr>")
map("n", "<Left>", ":bp<cr>")
map("n", "<Right>", ":bn<cr>")
map("c", "w!!", "w !sudo tee % >/dev/null")
map("i", "jk", "<esc>")
-- map("n", "<leader>ep", ":execute 'e ' . resolve(expand($MYVIMRC))<cr>")
-- map("n", "<leader>sv", ":source $MYVIMRC<cr>")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Don't enter ex-mode and command history mode respectively
map("n", "Q", "<nop>")
map({ "n", "v" }, "q:", "<nop>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })
map("n", "gx", function()
  -- test: "nthapaliya/dotfiles"
  local open = function(url)
    vim.cmd("silent! !open " .. vim.fn.shellescape(url, 1))
  end

  -- try for Plug/Packer style 'urls': aka "username/repo"
  if vim.bo.filetype == "lua" then
    local word = vim.fn.expand("<cWORD>")
    local matcher = '"(%S+/%S+)"'
    local match = string.match(word, matcher)

    if match ~= nil then
      local github_url = "https://github.com/" .. match
      open(github_url)
      return
    end
  end

  open(vim.fn.expand("<cfile>"))
end)
