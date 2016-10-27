" load pathogen
runtime bundle/vim-pathogen.git/autoload/pathogen.vim
execute pathogen#infect()

syntax on

set background=dark
set hls
set number
" counts line numbers from cursor current posision
set relativenumber
set nopaste
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
" scroll horizontally by small amount of text char instead of half of page
" (usefull for NERDTree)
set sidescroll=1
set noswapfile
set wildmenu
set nowrap
" make backspace work like most other apps
set backspace=2
" linux like command ident
set wildmode=longest,list,full
hi ColorColumn ctermbg=DarkRed

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

let mapleader = ","
" nerdtree.git plugin
nmap <leader>nt :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>
let NERDTreeShowHidden=1
" tagbar.git plugin
nmap <leader>tb :TagbarOpenAutoClose<cr>

" enable vim-better-whitespace.git plugin (removes whitespaces at EOL) on save
autocmd VimEnter * ToggleStripWhitespaceOnSave

" phpcomplete.vim.git plugin
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP filetype=php

let g:vdebug_options= {
\    "port" : 9000,
\    "server" : 'localhost',
\    "timeout" : 20,
\    "ide_key" : 'mrogacki'
\}

func! ToggleColumnIndicator()
	if &colorcolumn
		setlocal colorcolumn=""
	else
	    " show border for line 80 and lines after (inclusive) 120 characters
		let &colorcolumn="80,".join(range(120,999),",")
	endif
endfu

call ToggleColumnIndicator()
