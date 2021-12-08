" .vimrc {{{
set encoding=utf-8
scriptencoding utf-8
" }}}

" packer config {{{
lua << END
-- Skip some remote provider loading
vim.g.loaded_python_provider = 0
vim.g.python_host_prog = "/usr/bin/python2"
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.node_host_prog = "/usr/bin/neovim-node-host"

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  "gzip",
  "matchit",
  "matchparen",
  "shada_plugin",
  "tarPlugin",
  "tar",
  "zipPlugin",
  "zip",
  "netrwPlugin"
}

for _, name in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. name] = 1
end
END

lua << END
-- local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
--
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
-- end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- require('plugins')
END

" }}}

" basic settings {{{
set completeopt=menuone,noselect
set autoread
set background=dark
set breakindent
set clipboard^=unnamed,unnamedplus
" set cursorline
set hidden
set hlsearch
set ignorecase
set inccommand=nosplit
set infercase
set lazyredraw
set list
set listchars=trail:·,extends:#,tab:▸·,nbsp:·
set mouse=a
set noerrorbells
set noshowmode
set number
set scrolloff=8
set shell=bash
set shortmess+=c
set showbreak=\\\\\
" set signcolumn=number
set signcolumn=yes
set smartcase
set synmaxcol=300
set tabstop=2 sts=2 sw=2 expandtab
set tags^=./.git/tags;
set title
set updatetime=100
set visualbell
set laststatus=2
set showtabline=2

colorscheme tokyonight
" }}}

" keymappings {{{
let g:mapleader = "\<Space>"

cmap w!! w !sudo tee % >/dev/null
nnoremap <leader>W  :%s/\s\+$<cr>
nnoremap <leader>ev :execute 'e ' . resolve(expand($MYVIMRC))<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <Left>     :bprev<cr>
nnoremap <Right>    :bnext<cr>
" *N -> Search for word under cursor, highlight, jump back to prev word (*
" moves on to next)
" "zyiw -> yank word under cursor (iw) and store in register z
" :Rg <c-r>z -> Run : command Rg, <c-r>z replaces itself with z register
" contents
nnoremap <leader>*  *N"zyiw:Rg <c-r>z<cr>

inoremap jk <esc>
" don't enter ex-mode accidentally
nnoremap Q <nop>
" disable (for now) the command history mode
nnoremap q: <nop>

" Copy current file path to clipboard
" nmap <leader>cs :let @*=expand("%:p")<CR>
" }}}

" gui config {{{
if has('gui_running')
  set guioptions=
  set guifont=Fira Code:h13
endif
" }}}

" nvim config {{{
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
" }}}

" auto-commands {{{
augroup vim_filetype
  autocmd!
  " tip for 'nested' comes from https://github.com/itchyny/lightline.vim/commit/5374a50bbbabe5616b13b08fdf687a965b3c0486
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup TrimTrailingWhiteSpace
    au!
    au BufWritePre * %s/\s\+$//e
    au BufWritePre * %s/\n\+\%$//e
augroup END

augroup other_filetype_tweaks
  autocmd!
  autocmd FileType diff setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell commentstring=#\ %s
  autocmd FileType text setlocal spell commentstring=#\ %s textwidth=80
  autocmd FileType help wincmd L " open help window in vertical split
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab
  autocmd FileType ruby nnoremap <F5> :!time ruby %<cr>
  autocmd FileType rust nnoremap <F5> :!cargo run<cr>
  " autocmd FileType fzf set noshowmode noruler nonu
augroup END

augroup general_autocommands
  autocmd!
  autocmd VimResized * wincmd =
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
" }}}

" custom-commands {{{
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
" }}}

" junegunn/fzf {{{
" nnoremap <leader>p :Files<cr>
" nnoremap <leader>g :GFiles?<cr>
" nnoremap <leader>b :Buffers<cr>

" " https://github.com/junegunn/fzf.vim#hide-statusline
" augroup fzf
"   autocmd!
"   autocmd  FileType fzf set laststatus=0 noshowmode noruler
"     \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" augroup end
" " }}}

" unblevable/quick-scope {{{
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}

" telescope {{{
nnoremap <c-p> :Telescope find_files<cr>
nnoremap <leader>tb :Telescope buffers<cr>
nnoremap <leader>te :Telescope file_browser<cr>
nnoremap <leader>tg :Telescope git_status<cr>
nnoremap <leader>to :Telescope oldfiles<cr>
" }}}

" trouble {{{
nnoremap <leader>tt :TroubleToggle<cr>
" }}}

" formatter.nvim {{{
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tsx,*.json,*.lua,*.fish FormatWrite
augroup END
" }}}
