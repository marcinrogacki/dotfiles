"" Enable profiling to find what slow downs the Vim
" profile start vimprofile.log
" profile func *
" profile file *

"" vim-pathogen.git
" Load plugin loader
runtime bundle/vim-pathogen.git/autoload/pathogen.vim
execute pathogen#infect()

syntax on

" always highlight search
set hls
" do not jump to top when searched the last word
set nowrapscan
set nopaste
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set noswapfile
set wildmenu
set nowrap
set backspace=2 " make backspace work like most other apps
set history=1000
set wildmode=longest,list,full " Linux like command indent
let mapleader = ","
"" Spell checker
set spelllang=en
set spell
" Spell checker wrong word highlighting color
hi SpellBad ctermbg=88

" Appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color pallate
set term=screen-256color
set background=dark
" Show file line numbers
set number
" Cursor shows file current line, remaining are relative to it, e.g: 3 2 1 99 1 2 3
set relativenumber

"" Line markers
" Draws horizontal line mark on current cursor position to easier track long text
set cursorline
" Color of the horizontal line mark
hi CursorLine ctermbg=17
hi CursorLine cterm=none
" Draws vertical line mark on current cursor position to easier track long text
set cursorcolumn " enable
" Color of the vertical line mark
hi CursorColumn ctermbg=17

"" File margins
" Show where are 80 and 120+ column of file.
function! ToggleFileMarginsIndicator()
	if &colorcolumn
		setlocal colorcolumn=""
	else
		let &colorcolumn="80,".join(range(120,999),",")
	endif
endfu
" define shortcut for toggle collorcolumn
command! ToggleFileMarginsIndicator call ToggleFileMarginsIndicator()
" set nice colorcolumn color
hi ColorColumn ctermbg=235
" show colorcolumn at the startup (by exec function)
autocmd VimEnter * call ToggleFileMarginsIndicator()

" Custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Converts table from mysql to csv
function! MysqltableToCsv()
    normal Gdd3Gdd1Gdd
    %s/^| */"/g | %s/ *|$/"/g |  %s/ *| */","/g
endfu

"" push =json in visual mode and json file will be formatted
nmap =json :%!python -m json.tool<CR>

"" [o]pposite [d]elete in (v)isual mode
vmap od ygg"_dGP

" What is it?
filetype on
filetype plugin indent on
map <C-s> :w <Enter>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Language specifics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" typescript
" Indent by two spaces instead four
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

"" graphql
" Indent by two spaces instead four
autocmd FileType graphql setlocal shiftwidth=2 softtabstop=2

" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" nerdtree.git
nmap <leader>nt :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>
let NERDTreeShowHidden=1
" scroll horizontally by small amount of text char instead of half of page
" (usefull for NERDTree)
set sidescroll=1
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
" Don't show those files
let NERDTreeIgnore = ['\.js$' , '\.d.ts$']

"" tagbar.git
nmap <leader>tb :TagbarOpenAutoClose<cr>

"" vim-airline.git
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='simple'

"" ctrlp.vim
" use 'ag' instead 'grep' to boost serach performance
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" Ignore unnecessary files. Speeds up searching the files.
let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules\|\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(d.ts|js)$',
  \ }

" Scan hidden files
let g:ctrlp_show_hidden = 1

"" vim-better-whitespace.git
" enable vim-better-whitespace.git plugin (removes whitespaces at EOL) on save
autocmd VimEnter * ToggleStripWhitespaceOnSave

" vim-adnroid
let g:android_sdk_path = '/opt/android-sdk'

"" vim-mark.git
" Remove the default overriding of * and #. Conflicts with IndexedSearch.vim
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

"" govim
set mouse=a " To get hover work
set ttymouse=sgr " To get hover working
" map hover to key
nmap <silent> <buffer> <Leader>gh : <C-u>call GOVIMHover()<CR>

"" vim-markdown.git
" disable folding
let g:vim_markdown_folding_disabled = 1

"" Plugin vim-prettier
" Enable on save without defining @format in header
let g:prettier#autoformat_require_pragma = 0
" Use .prettierrc config if present
let g:prettier#autoformat_config_present = 1
" By default we auto focus on the quickfix when there are errors but can also
" be disabled
let g:prettier#quickfix_auto_focus = 0
" prettier downloaded from yarn in project doesn't work stable (config issue?)
" workaround by using global
let g:prettier#exec_cmd_path = "~/.node_modules/bin/prettier"
