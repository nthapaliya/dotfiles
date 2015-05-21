" Pathogen and a few simple commands
execute pathogen#infect()
syntax on
filetype plugin indent on
set number
set nocompatible

" vim-go 
let g:go_fmt_command = "goimports"

" Powerline tidbits
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" For solarized
"let g:solarized_termcolors=256
"syntax enable
"set background=dark
"colorscheme solarized

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

set ts=2 sts=2 sw=2 expandtab
