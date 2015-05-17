execute pathogen#infect()
syntax on
filetype plugin indent on
set number

let g:go_fmt_command = "goimports"

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
