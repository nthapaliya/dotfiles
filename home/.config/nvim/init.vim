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
  " vim-airline/vim-airline {{{
  Plug 'vim-airline/vim-airline'
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
Plug 'morhetz/gruvbox'

" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Other languages
  " fatih/vim-go {{{
  Plug 'fatih/vim-go'
  let g:go_fmt_command = 'goimports'
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  " }}}
Plug 'rodjek/vim-puppet'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-scripts/Arduino-syntax-file'

" Vim enhancements

  " junegunn/fzf {{{
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
  Plug 'junegunn/fzf.vim'

  if $COMPATIBILITY
    nnoremap <C-p> :Files!<cr>
  else
    nnoremap <C-p> :Files<cr>
  endif

  if has('gui_macvim')
    let g:fzf_launcher = 'run_fzf %s'
  endif
  " }}}

  " unblevable/quick-scope {{{
  Plug 'unblevable/quick-scope'          " handy for f and t commands
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    " I'm not keeping this to enable true color, thats been deprecated
    " I'm keeping this to 'fix' quick-scope
    " https://github.com/unblevable/quick-scope/issues/32#issuecomment-241159662
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  " }}}

" Plug 'ConradIrwin/vim-bracketed-paste' " TODO: Find out if I still need this
Plug 'AndrewRadev/splitjoin.vim'         " add gS and gJ mappings for smart splitting and joining of blocks
Plug 'mhinz/vim-grepper'
Plug 'airblade/vim-gitgutter'            " show git marks on gutter
" airblade/vim-rooter {{{
  Plug 'airblade/vim-rooter'               " vim opened in a sub-dir chdir's to git root
  " ignore node_modules, as it's no longer a good indicator of root-edness
  let g:rooter_patterns = ['.git/']
" }}}
Plug 'christoomey/vim-tmux-navigator'    " jump between vim and tmux panes easily
Plug 'justinmk/vim-sneak'                " s <char> <char> motions
Plug 'tommcdo/vim-lion'                  " easily align things
Plug 'tpope/vim-commentary'              " gc and gcc to comment/uncomment lines
Plug 'tpope/vim-fugitive'                " git wrapper
Plug 'tpope/vim-repeat'                  " extends . commands
Plug 'tpope/vim-rhubarb'                 " extends fugitive for use with github
if !has('nvim')
  Plug 'tpope/vim-sensible'                " sensible defaults
endif
Plug 'tpope/vim-surround'                " shortcuts for adding deleting or changing parens and quotes
Plug 'tpope/vim-unimpaired'              " handy shortcuts which I can never remember
Plug 'tpope/vim-vinegar'                 " wrapper around netrw, file manager

" Linters
  " neomake/neomake {{{
  Plug 'neomake/neomake'
  augroup neomake_trigger_autocommands
    autocmd!
    autocmd BufWritePost * Neomake
  augroup end

  " Callback for reloading file in buffer when eslint_d or rubocop has finished and maybe has
  " autofixed some stuff
  if !has('gui')
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
  let g:neomake_javascript_eslint_d_exe = 'eslint_x'

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

call plug#end()
" }}}

" basic settings {{{

set autoread
set background=dark                                 " dark theme
set clipboard^=unnamed                              " adds unnamed to existing values
set cursorline                                      " highlight the cursorline
set hidden                                          " can change buffers even if current is not written
set lazyredraw                                      " Don't update screen while macros are executing
set list                                            " enable list characters
set listchars=trail:·,extends:#,tab:▸·,nbsp:·       " specify list characters
set mouse=a                                         " mouse scroll and focus working in vim
set noerrorbells                                    " don't beep
set noshowmode                                      " don't need to echo mode
set number                                          " show numbers in side gutter
set scrolloff=8                                     " leave 8 lines on top and bottom while scrolling
set shell=$SHELL                                    " default shell set by environment
set smartcase                                       " search case setting
set synmaxcol=300                                   " do not highlight very long lines
set tabstop=2 sts=2 sw=2 expandtab                  " tab-settings
set termguicolors                                   " enable true-color
set title                                           " titlebar will be buffer filename
set visualbell                                      " don't beep

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
nnoremap <leader>W  :%s/\s\+$<cr>                                 " to clean up trailing whitespace
nnoremap <leader>ev :execute 'e ' . resolve(expand($MYVIMRC))<CR> " quickly edit vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>                          " quickly source vimrc
nnoremap <Left> :bprev<cr>
nnoremap <Right> :bnext<cr>

inoremap jk <esc>
inoremap <esc> <nop>
nnoremap Q <nop>     " don't enter ex mode accidentally

nnoremap <leader>* :Ag <C-r>=expand('<cword>')<CR><CR>
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
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC              " auto reload vimrc on save
  autocmd FileType vim setlocal foldmethod=marker                   " vim filetype fold markers
augroup END

augroup other_filetype_tweaks
  autocmd!
  autocmd BufRead,BufNewFile *.{es6} set filetype=javascript        " set all `es6` extensions to javascript
  autocmd FileType diff setlocal commentstring=#\ %s                " comment string for git diff
  autocmd FileType gitcommit setlocal commentstring=#\ %s           " comment string for git commit message
  autocmd FileType help wincmd L                                    " open help window in vertical split
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab      " tab-settings
augroup END

" }}}

" custom-commands {{{
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
" }}}
