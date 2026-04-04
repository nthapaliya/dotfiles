" If nvim is not available, for short-term use in a pinch
" Does not automatically symlink, copy to home to use
" vim-plug config {{{
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" for vim in tmux only
" :help xterm-true-color
" https://github.com/vim/vim/issues/993
if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if !has('gui_running')
  set t_Co=256
endif

colorscheme habamax

call plug#begin('~/.vim/plugged')

" Vim enhancements
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'
Plug 'ojroques/vim-oscyank'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/BufOnly.vim'

call plug#end()
" }}}

" basic settings {{{
scriptencoding utf-8
syntax on
filetype plugin indent on

set autoindent
" set autoread
set background=dark
set backspace=indent,eol,start
set backupdir=~/.local/share/vim//,/tmp//
set breakindent
set clipboard^=unnamed,unnamedplus
set directory=~/.local/share/vim//,/tmp//
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=trail:·,extends:#,tab:▸·,nbsp:·
set mouse=a
set noerrorbells
set number
set ruler
set scrolloff=8
set shell=bash
set shortmess+=c
set showbreak=\\\\\
set showmatch
set smartcase
set synmaxcol=300
set tabstop=2 sts=2 sw=2 expandtab
set tags^=./.git/tags;
set title
set wildmenu

" autocmds {{{
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" keymappings {{{
let g:mapleader = "\<Space>"

cmap w!! w !sudo tee % >/dev/null
nnoremap <C-p>     :bprev<cr>
nnoremap <C-n>     :bnext<cr>

nnoremap <leader>ev :execute 'e ' . resolve(expand($MYVIMRC))<CR>
inoremap jk <esc>
nnoremap Q <nop> " don't enter ex mode accidentally
" }}}

" vim-airline/vim-airline {{{
let g:airline#extensions#branch#displayed_head_limit = 8

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
" }}}

" other settings {{{
let g:oscyank_silent = v:true
let g:matchup_matchparen_offscreen = {}
" }}}
