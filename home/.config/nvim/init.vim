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

" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Other languages
Plug 'dag/vim-fish'
Plug 'rodjek/vim-puppet'
Plug 'tmux-plugins/vim-tmux'

" Vim enhancements
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'unblevable/quick-scope'

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
set clipboard^=unnamed
set cursorline
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
set shell=/bin/bash
set showbreak=\\\\\
set smartcase
set synmaxcol=300
set tabstop=2 sts=2 sw=2 expandtab
if $TERM_PROGRAM == 'Iterm.app'
  set termguicolors
endif
set title
set visualbell

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
  set guifont=Literation\ Mono\ Powerline:h13
endif
" }}}

" nvim config {{{
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
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
command! This execute 'Ag ' . expand('%:t')
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

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}

" junegunn/fzf {{{
nnoremap <C-p> :Files<cr>
nnoremap <leader>b :Buffers<cr>

" https://github.com/junegunn/fzf.vim#hide-statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}

" unblevable/quick-scope {{{
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" I'm not keeping this to enable true color, thats been deprecated
" I'm keeping this to 'fix' quick-scope
" https://github.com/unblevable/quick-scope/issues/32#issuecomment-241159662
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}

" Plug 'w0rp/ale' {{{
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_executable = 'eslintme'
let g:ale_fix_on_save = 1
" }}}
