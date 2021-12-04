" basic settings {{{
scriptencoding utf-8
syntax on
filetype plugin indent on

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set breakindent
set clipboard^=unnamed,unnamedplus
set encoding=utf-8
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
set updatetime=100
set visualbell
set wildmenu

" for vim in tmux only
" :help xterm-true-color
" https://github.com/vim/vim/issues/993
if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" }}}

" keymappings {{{
let g:mapleader = "\<Space>"

cmap w!! w !sudo tee % >/dev/null
nnoremap <leader>W  :%s/\s\+$<cr>
nnoremap <leader>ev :execute 'e ' . resolve(expand($MYVIMRC))<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <Left>     :bprev<cr>
nnoremap <Right>    :bnext<cr>
nnoremap ]<space>   o<esc>
nnoremap [<space>   O<esc>

inoremap jk <esc>
nnoremap Q <nop> " don't enter ex mode accidentally
" }}}

" auto-commands {{{
augroup vim_filetype
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup other_filetype_tweaks
  autocmd!
  autocmd FileType diff setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell commentstring=#\ %s
  autocmd FileType text setlocal spell commentstring=#\ %s textwidth=80
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab
augroup END
