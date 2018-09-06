" .vimrc {{{
set encoding=utf-8
scriptencoding utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  augroup first_time_setup
    autocmd!
    autocmd VimEnter * PlugInstall
  augroup end
endif
" }}}

" vim-plug config {{{
call plug#begin('~/.config/nvim/plugged')

" Colors and themes
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'

" Language enhancements
Plug 'sheerun/vim-polyglot'
" Plug 'tpope/vim-rails'
Plug 'jparise/vim-graphql'

" Vim enhancements
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all --xdg' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'justinmk/vim-dirvish'
Plug 'machakann/vim-sandwich'
Plug 'mhinz/vim-grepper'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'unblevable/quick-scope'
Plug 'wincent/terminus'

" Tests from vim
Plug 'janko-m/vim-test'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-dispatch'

" Linter
Plug 'w0rp/ale'

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

call plug#end()
" }}}

" basic settings {{{
set autoread
set background=dark
set breakindent
" Mac specific: clipboard.vim was adding 500-800ms to startup time. This fixes
" that (for now)
let g:clipboard = {
\ 'copy': {
\   '+': 'pbcopy',
\   '*': 'pbcopy'
\ },
\ 'paste': {
\   '+': 'pbpaste',
\   '*': 'pbpaste'
\ },
\ 'name': 'pbcopy',
\ 'cache_enabled': 0
\ }
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
set shell=fish
set showbreak=\\\\\
set smartcase
set synmaxcol=300
set tabstop=2 sts=2 sw=2 expandtab
set title
set visualbell
set termguicolors
set updatetime=100

if has('nvim')
  set inccommand=nosplit
  set incsearch
endif

set path+=app/javascript,node_modules

if !has('nvim')
  set viminfo+=n~/.vim/viminfo
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

inoremap jk <esc>
nnoremap Q <nop> " don't enter ex mode accidentally
nnoremap <leader>* :Grepper -tool rg -cword -noprompt<cr>

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
  tnoremap jk <C-\><C-n>
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
  autocmd BufRead,BufNewFile *.{es6} set filetype=javascript
  autocmd FileType diff setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell commentstring=#\ %s
  autocmd FileType text setlocal spell commentstring=#\ %s textwidth=80
  autocmd FileType help wincmd L " open help window in vertical split
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab
augroup END

augroup general_autocommands
  autocmd VimResized * wincmd =
augroup END
" }}}

" custom-commands {{{
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
" Work specific - Use :This to find which files import the current javascript
" file
command! This call fzf#run(fzf#wrap({
\ 'options': '-m',
\ 'sink': 'e',
\ 'source': "jq -r '.[\"" . @% . "\"][]' .git/deps.json"
\ }))

command! Vdirty call fzf#run(fzf#wrap({
\ 'options': "-m",
\ 'sink': 'e',
\ 'source': "git status -s | awk '{ print $NF }' "
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
\ 'ruby': ['rubocop'],
\ }

let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_executable = 'eslintme'
let g:ale_fix_on_save = 1

nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
" }}}

" Plug 'janko-m/vim-test' {{{
let g:test#strategy = 'dispatch'
" }}}
