" load pathogen
runtime bundle/vim-pathogen.git/autoload/pathogen.vim
execute pathogen#infect()

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
set noswapfile
set wildmenu
set backspace=2 " make backspace work like most other apps
set wildmode=longest,list,full " linux like command ident

if filereadable(".ctags")
    set tags=.ctags
endif

filetype on
filetype plugin indent on

:map <C-s> :w <Enter>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" push =json in visual mode and json file will be formatted
nmap =json :%!python -m json.tool<CR>

" [o]pposite [d]elete in (v)isual mode
vmap od ygg"_dGP

" nerdtree.git plugin
let mapleader = ","
nmap <leader>nt :NERDTree<cr>
nmap <leader>nm :NERDTreeMirror<cr>
nmap <leader>nf :NERDTreeFind<cr>

" vim-better-whitespace.git plugin
autocmd VimEnter * ToggleStripWhitespaceOnSave

" phpcomplete.vim.git plugin
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP filetype=php
