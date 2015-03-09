runtime bundle/vim-pathogen.git/autoload/pathogen.vim

syntax on

set background=dark
set hls
set number
set nopaste
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set backspace=2 " make backspace work like most other apps
set noswapfile

if filereadable(".ctags")
    set tags=.ctags
endif

" linux like command ident
set wildmode=longest,list,full

set wildmenu
" set backupdir=/tmp/vim

execute pathogen#infect()

" remove trailing whitespace when saving a file
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
filetype on
filetype plugin indent on
set filetype=php

inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

:map <C-s> :w <Enter>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
let mapleader = ","
nmap <leader>nt :NERDTree<cr>
nmap <leader>nm :NERDTreeMirror<cr>
nmap <leader>nf :NERDTreeFind<cr>

" push =json in visual mode and json file will be formatted
nmap =json :%!python -m json.tool<CR>
" [o]pposite [d]elete in (v)isual mode
vmap od ygg"_dGP
" [m]agento var/log/system.log format json
nmap =mjson f{v%od0=json

"au VimEnter *  NERDTree

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
