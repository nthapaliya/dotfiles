-- Keymaps
local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "<leader>W", [[:%s/\s\+$<cr>]])
map("n", "<leader>ev", ":execute 'e ' . resolve(expand($MYVIMRC))<cr>")
map("n", "<leader>d", ":cd ~/Projects/dotfiles<cr>")
map("n", "<S-Left>", ":bp<cr>", { desc = "Prev buffer" })
map("n", "<S-Right>", ":bn<cr>", { desc = "Next buffer" })
map("c", "w!!", "w !sudo tee % >/dev/null")
map("i", "jk", "<esc>")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Don't enter ex-mode and command history mode respectively
map("n", "Q", "<nop>")
map({ "n", "v" }, "q:", "<nop>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

vim.cmd([[cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"]])
vim.cmd([[cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"]])

-- Commands
vim.cmd([[nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>]])

-- Rewrite these in lua
vim.cmd([[
command! Today execute 'normal Go<esc>'    | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G'   | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
]])

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
end, { desc = "Open short style urls in Github" })
