lua require('init')

augroup Packer
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END

command! PackerInstall packadd packer.nvim | lua require('plugins').install()
command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
command! PackerSync packadd packer.nvim | lua require('plugins').sync()
command! PackerClean packadd packer.nvim | lua require('plugins').clean()
command! PackerCompile packadd packer.nvim | lua require('plugins').compile()

lua vim.g.mapleader = ' '
" let g:mapleader = "\<Space>"
cmap w!! w !sudo tee % >/dev/null
nnoremap <leader>W  :%s/\s\+$<cr>
nnoremap <leader>ev :execute 'e ' . resolve(expand($MYVIMRC))<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <Left>     :bprev<cr>
nnoremap <Right>    :bnext<cr>
" *N -> Search for word under cursor, highlight, jump back to prev word (*
" moves on to next)
" "zyiw -> yank word under cursor (iw) and store in register z
" :Rg <c-r>z -> Run : command Rg, <c-r>z replaces itself with z register
" contents
" TODO: Find a way to do this in Telescope
" nnoremap <leader>*  *N"zyiw:Rg <c-r>z<cr>

inoremap jk <esc>
" don't enter ex-mode accidentally
nnoremap Q <nop>
" disable (for now) the command history mode
nnoremap q: <nop>
" }}}

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

augroup vim_filetype
  autocmd!
  " tip for 'nested' comes from https://github.com/itchyny/lightline.vim/commit/5374a50bbbabe5616b13b08fdf687a965b3c0486
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup TrimTrailingWhiteSpace
    au!
    au BufWritePre * %s/\s\+$//e
    au BufWritePre * %s/\n\+\%$//e
augroup END

augroup other_filetype_tweaks
  autocmd!
  autocmd FileType diff setlocal commentstring=#\ %s
  autocmd FileType gitcommit setlocal spell commentstring=#\ %s
  autocmd FileType text setlocal spell commentstring=#\ %s textwidth=80
  " autocmd FileType help wincmd L " open help window in vertical split
  autocmd FileType markdown set tabstop=4 sts=4 sw=4 expandtab
  autocmd FileType ruby nnoremap <F5> :!time ruby %<cr>
  autocmd FileType rust nnoremap <F5> :!cargo run<cr>
augroup END

augroup general_autocommands
  autocmd!
  autocmd VimResized * wincmd =
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.tsx,*.json,*.lua,*.fish FormatWrite
augroup END

command! Today execute 'normal Go<esc>' | r!date "+\%F (\%a \%b \%d)"
command! -nargs=* Now execute 'normal G' | execute 'r!date "+- \%R - "' | execute 'normal! A' . <q-args> . '<esc>'

" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
lua vim.g.qs_highlight_on_keys = {'f','F','t','T'}

nnoremap <c-p> :Telescope find_files<cr>
nnoremap <leader>tb :Telescope buffers<cr>
nnoremap <leader>te :Telescope file_browser<cr>
nnoremap <leader>tg :Telescope git_status<cr>
nnoremap <leader>to :Telescope oldfiles<cr>

nnoremap <leader>tt :TroubleToggle<cr>
