local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand-- Globals

-- Autocmds
local autocmds = {
  filetype = {
    { event = "FileType", pattern = "diff", command = [[setlocal commentstring=#\ %s]] },
    { event = "FileType", pattern = "gitcommit", command = [[setlocal spell commentstring=#\ %s textwidth=80]] },
    { event = "FileType", pattern = "markdown", command = "setlocal tabstop=4 sts=4 sw=4 expandtab" },
    { event = "FileType", pattern = "ruby", command = "nnoremap <F5> :!time ruby %<cr>" },
    { event = "FileType", pattern = "rust", command = "nnoremap <F5> :!cargo run<cr>" },
    { event = "FileType", pattern = "java", command = "nnoremap <F5> :!java %<cr>" },
    { event = "FileType", pattern = "go", command = "nnoremap <F5> :!go run .<cr>" },
    { event = "FileType", pattern = "text", command = [[setlocal spell commentstring=#\ %s textwidth=80]] },
  },

  general = {
    { event = "VimResized", pattern = "*", command = "wincmd =" },
    -- Don't auto comment new lines
    -- { event = "BufEnter", pattern = "", command = "set fo-=c fo-=r fo-=o" },
  },
}

for group_name, definitions in pairs(autocmds) do
  local group_id = augroup(group_name, { clear = true })
  for _, definition in ipairs(definitions) do
    local autocmd_event = definition.event
    definition.event = nil
    definition.group = group_id
    autocmd(autocmd_event, definition)
  end
end
