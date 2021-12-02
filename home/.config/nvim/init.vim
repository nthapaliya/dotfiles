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
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'andymass/vim-matchup'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'unblevable/quick-scope'
Plug 'wincent/terminus'
Plug 'zenbro/mirror.vim'

" File/buffer management
Plug 'justinmk/vim-dirvish'
Plug 'rbgrouleff/bclose.vim'
Plug 'vim-scripts/BufOnly.vim'

" Linter
Plug 'dense-analysis/ale'

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
set hlsearch
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
set title
set updatetime=100
set visualbell

if has('nvim')
  set inccommand=nosplit
else
  set viminfo+=n~/.local/share/nvim/viminfo
endif

set path+=app/javascript,node_modules

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
" *N -> Search for word under cursor, highlight, jump back to prev word (*
" moves on to next)
" "zyiw -> yank word under cursor (iw) and store in register z
" :Rg <c-r>z -> Run : command Rg, <c-r>z replaces itself with z register
" contents
nnoremap <leader>*  *N"zyiw:Rg <c-r>z<cr>
command! Bd bp\|bd \#

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
  autocmd FileType rust nnoremap <F5> :!cargo run<cr>
  autocmd  FileType fzf set noshowmode noruler nonu
augroup END

augroup general_autocommands
  autocmd!
  autocmd VimResized * wincmd =
augroup END
" }}}

" custom-commands {{{
command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'
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
nnoremap <C-g> :GFiles?<cr>
nnoremap <leader>b :Buffers<cr>

" https://github.com/junegunn/fzf.vim#hide-statusline
augroup fzf
  autocmd!
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end

" Using floating windows of Neovim to start fzf
if has('nvim')
  function! FloatingFZF(width, height, border_highlight)
    function! s:create_float(hl, opts)
      let buf = nvim_create_buf(v:false, v:true)
      let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
      let win = nvim_open_win(buf, v:true, opts)
      call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
      call setwinvar(win, '&colorcolumn', '')
      return buf
    endfunction

    " Size and position
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)

    " Border
    let top = '╭' . repeat('─', width - 2) . '╮'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '╰' . repeat('─', width - 2) . '╯'
    let border = [top] + repeat([mid], height - 2) + [bot]

    " Draw frame
    let s:frame = s:create_float(a:border_highlight, {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
    autocmd BufWipeout <buffer> execute 'bwipeout' s:frame
  endfunction

  let g:fzf_layout = { 'window': 'call FloatingFZF(0.9, 0.6, "Comment")' }

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
endif

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
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

let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

let g:ale_fixers = {
\ 'fish': ['Fish_indent'],
\ 'javascript': ['prettier'],
\ 'javascriptreact': ['prettier'],
\ 'json': ['jq'],
\ 'jsonc': ['jq'],
\ 'ruby': ['rubocop'],
\ 'rust': ['rustfmt'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ }

let g:airline#extensions#ale#enabled = 1
let g:ale_javascript_eslint_executable = 'eslintme'
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1

let g:ale_rust_cargo_check_tests = 1

nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
" }}}
