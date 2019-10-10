" .vimrc {{{
set encoding=utf-8
scriptencoding utf-8
" }}}

" vim-plug config {{{
call plug#begin('~/.local/opt/nvim/plugged')

" Colors and themes
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'

" Language enhancements
Plug 'sheerun/vim-polyglot'

" Vim enhancements
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all --xdg' }
Plug 'junegunn/fzf.vim'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'unblevable/quick-scope'
Plug 'wincent/terminus'
Plug 'tpope/vim-dispatch'

" File/buffer management
Plug 'justinmk/vim-dirvish'
Plug 'rbgrouleff/bclose.vim'
Plug 'vim-scripts/BufOnly.vim'

" Linter
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

call plug#end()
" }}}

" basic settings {{{
set autoread
set background=dark
set breakindent
set clipboard^=unnamed,unnamedplus
" set cursorline
" set cursorcolumn
set hidden
set ignorecase
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
set signcolumn=yes
set smartcase
set synmaxcol=300
set tabstop=2 sts=2 sw=2 expandtab
set tags^=./.git/tags;
set termguicolors
set title
set updatetime=100
set visualbell

if has('nvim')
  set inccommand=nosplit
endif

set path+=app/javascript,node_modules

if !has('nvim')
  set viminfo+=n~/.local/share/nvim/viminfo
endif

" for vim in tmux only
" :help xterm-true-color
" https://github.com/vim/vim/issues/993
if !has('nvim') && exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme gruvbox
" }}}

" keymappings {{{
let g:mapleader = "\<Space>"

cmap w!! w !sudo tee % >/dev/null
nnoremap <leader>W  :%s/\s\+$<cr>
nnoremap <leader>ev :execute 'e ' . resolve(expand($MYVIMRC))<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <Left>     :bprev<cr>
nnoremap <Right>    :bnext<cr>
nnoremap <leader>*  *N"zyiw:Rg <c-r>z<cr>
" *N -> Search for word under cursor, highlight, jump back to prev word (*
" moves on to next)
" "zyiw -> yank word under cursor (iw) and store in register z
" :Rg <c-r>z -> Run : command Rg, <c-r>z replaces itself with z register
" contents

inoremap jk <esc>
nnoremap Q <nop> " don't enter ex mode accidentally

nmap <leader>cs :let @*=expand("%:p")<CR>
" }}}

" gui config {{{
if has('gui_running')
  set guioptions=
  set guifont=Fira Code:h13
endif
" }}}

" nvim config {{{
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  " tnoremap jk <C-\><C-n>
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
endif
" }}}

" auto-commands {{{
augroup vim_filetype
  autocmd!
  " tip for 'nested' comes from https://github.com/itchyny/lightline.vim/commit/5374a50bbbabe5616b13b08fdf687a965b3c0486
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup other_filetype_tweaks
  autocmd!
  autocmd FileType diff setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell commentstring=#\ %s
  autocmd FileType text setlocal spell commentstring=#\ %s textwidth=80
  autocmd FileType help wincmd L " open help window in vertical split
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab
  autocmd FileType ruby nnoremap <F5> :!time ruby %<cr>
augroup END

augroup general_autocommands
  autocmd!
  autocmd VimResized * wincmd =
augroup END
" }}}

" custom-commands {{{
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'

function! HandleInputs_(items)
  execute 'edit' a:items[0]
  for  filename in a:items[1:]
    execute 'badd' filename
  endfor
endfunction

let HandleInputs = function('HandleInputs_')

" Work specific - Use :This to find which files import the current javascript
" file
command! This call fzf#run(fzf#wrap({
\ 'options': '-m --with-nth 3.. --delimiter /',
\ 'sink*': HandleInputs,
\ 'source': "get-js-deps " . @%
\ }))

" }}}

" vim-airline/vim-airline {{{
let g:airline#extensions#branch#displayed_head_limit = 8

" Short forms, lets see if worth it
let g:airline_mode_map = {
\ '__' : '-',
\ 'n'  : 'N',
\ 'i'  : 'I',
\ 'R'  : 'R',
\ 'c'  : 'C',
\ 'v'  : 'V',
\ 'V'  : 'V',
\ '' : 'V',
\ 's'  : 'S',
\ 'S'  : 'S',
\ '' : 'S',
\ }

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

" }}}

" junegunn/fzf {{{
nnoremap <C-p> :Files<cr>
nnoremap <leader>b :Buffers<cr>

" https://github.com/junegunn/fzf.vim#hide-statusline
augroup fzf
  autocmd!
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end
" }}}

" unblevable/quick-scope {{{
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}

" Plug 'w0rp/ale' {{{
function! Fish_indent(buffers)
  return {
  \ 'command': 'fish_indent -w %t',
  \ 'read_temporary_file': 1,
  \ 'suggested_filetypes': ['fish']
  \ }
endfunction

let g:ale_fixers = {
\ 'fish': ['Fish_indent'],
\ 'javascript': ['prettier'],
\ 'javascriptreact': ['prettier'],
\ 'ruby': ['rubocop'],
\ 'rust': ['rustfmt'],
\ }

let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_executable = 'eslintme'
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1

nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
" }}}

" Plug 'janko-m/vim-test' {{{
let g:test#strategy = 'dispatch'
" }}}

" Plug 'francoiscabrol/ranger.vim' {{{
let g:ranger_replace_netrw = 0
" }}}
