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
Plug 'rodjek/vim-puppet'
Plug 'tmux-plugins/vim-tmux'

" Vim enhancements
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
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

Plug 'neomake/neomake'
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
set shell=$SHELL
set showbreak=\\\\\
set smartcase
set synmaxcol=300
set tabstop=2 sts=2 sw=2 expandtab
set termguicolors
set title
set visualbell

" for vim in tmux only
" :help xterm-true-color
" https://github.com/vim/vim/issues/993
if !has('nvim') && exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

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
nnoremap <Left> :bprev<cr>
nnoremap <Right> :bnext<cr>

inoremap jk <esc>
nnoremap Q <nop> " don't enter ex mode accidentally
nnoremap <leader>* :Grepper -tool rg -cword -noprompt<cr>
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
  autocmd FileType gitcommit setlocal commentstring=#\ %s
  autocmd FileType help wincmd L " open help window in vertical split
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab
augroup END

" }}}

" custom-commands {{{
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
" }}}

" vim-airline/vim-airline {{{
if $COMPATIBILITY
  let g:airline_left_sep=' '
  let g:airline_right_sep=' '
else
  let g:airline_powerline_fonts = 1
endif

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

if has('gui_macvim')
  let g:fzf_launcher = 'run_fzf %s'
endif
" }}}

" unblevable/quick-scope {{{
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" I'm not keeping this to enable true color, thats been deprecated
" I'm keeping this to 'fix' quick-scope
" https://github.com/unblevable/quick-scope/issues/32#issuecomment-241159662
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}

" airblade/vim-rooter {{{
let g:rooter_patterns = ['.git/']
" }}}

" neomake/neomake {{{
augroup neomake_trigger_autocommands
  autocmd!
  autocmd BufWritePost * Neomake
augroup end

" Callback for reloading file in buffer when eslint_d
" or rubocop has finished and maybe has autofixed some stuff
if !has('gui_running')
  augroup reload_non_gui
    autocmd!
    autocmd User NeomakeJobFinished nested call s:OnNeomakeJobFinished()
  augroup end

  silent function! s:OnNeomakeJobFinished()
  let l:exit_code = g:neomake_hook_context.jobinfo.exit_code
  let l:name = g:neomake_hook_context.jobinfo.maker.name
  if (l:name ==# 'eslint_d' || l:name ==# 'rubocop')
    " checktime
    edit
  endif
endfunction
endif

" take the eslint_d args from source and add --fix
let g:neomake_javascript_eslint_d_args = ['-f', 'compact', '--fix']
let g:neomake_javascript_eslint_d_exe = 'eslint_d'

" take the rubocop maker from source and add -a -R -D to args
" add a mapexpr to rubocop maker to remove strings with [Corrected]
let g:neomake_ruby_rubocop_maker = {
      \ 'args': ['--format', 'emacs', '-a', '-R'],
      \ 'errorformat': '%f:%l:%c: %t: %m',
      \ 'mapexpr': 'substitute(v:val, ".\\+\\[Corrected\\].\\+", "", "g")',
      \ 'postprocess': function('neomake#makers#ft#ruby#RubocopEntryProcess'),
      \ }

" after setup, enable for filetypes
let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_jsx_enabled_makers = ['eslint_d']
" }}}
