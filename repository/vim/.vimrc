" load pathogen
runtime bundle/vim-pathogen.git/autoload/pathogen.vim
execute pathogen#infect()

syntax on

set hls " always highlight search
set nowrapscan " do not jump to top when searched the last word
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

"" Appearance
set term=screen-256color
set background=dark

"" File line numbers
set number
" cursor shows file current line, remaining are relative to it, e.g: 3 2 1 99 1 2 3
set relativenumber

"" Spell checker
set spelllang=en
set spell
" style
hi SpellBad ctermbg=88

"" Cursor horizontal line
" Draws underline on current cursor position to easier track long text
set cursorline
" style
hi CursorLine ctermbg=59
hi CursorLine cterm=none

"" Cursor vertical line
set cursorcolumn " enable
" style
hi CursorColumn ctermbg=59

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

"" ctags
if filereadable(".tags")
  set tags=.tags
endif
" deletes all entries of certain file in .tags
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/.tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction
" updates tags of current selected file
function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let cmd = 'ctags -a "' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
" call update tags of current file on each write
" autocmd BufWritePost * call UpdateTags()
" allows using ctrl+[ (tags) to jump to function definition (only when cscope
" is available)
if has('cscope')
  set cscopetag cscopeverbose
  " add cscope database
  if filereadable(".vim/cscope/cscope.out")
    silent cs add .vim/cscope/cscope.out
  endif
endif

""
filetype on
filetype plugin indent on

:map <C-s> :w <Enter>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"" push =json in visual mode and json file will be formatted
nmap =json :%!python -m json.tool<CR>

"" [o]pposite [d]elete in (v)isual mode
vmap od ygg"_dGP

let mapleader = ","

" nerdtree.git plugin
nmap <leader>nt :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>
let NERDTreeShowHidden=1
" scroll horizontally by small amount of text char instead of half of page
" (usefull for NERDTree)
set sidescroll=1
" enable line numbers
let NERDTreeShowLineNumbers=1
" " make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"" tagbar.git plugin
nmap <leader>tb :TagbarOpenAutoClose<cr>

"" plugin: ctrlp.vim
" use 'ag' instead 'grep' to boost serach performance
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"" vim-airline.git
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='simple'
let g:airline#extensions#tagbar#enabled = 1

"" vim-better-whitespace.git
" enable vim-better-whitespace.git plugin (removes whitespaces at EOL) on save
autocmd VimEnter * ToggleStripWhitespaceOnSave

"" phpcomplete.vim.git plugin
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP filetype=php

"" plugin: syntastic.git - syntax checker
let g:syntastic_php_checkers = ['php', 'go']
" Each java project will defind it's class path in file
" It was added to support Gradle projects (mostly Android)
let g:syntastic_java_checkers=['javac']
let g:syntastic_java_javac_config_file_enabled = 1

" vim-adnroid
let g:android_sdk_path = '/opt/android-sdk'

"" plugin: vim-mark.git
" Remove the default overriding of * and #. Conflicts with IndexedSearch.vim
" plugin
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

"" Markdown
let g:vim_markdown_folding_disabled = 1 " disable folding (vim-markdown.git)

"" Converts table from mysql to csv
function! MysqltableToCsv()
    normal Gdd3Gdd1Gdd
    %s/^| */"/g | %s/ *|$/"/g |  %s/ *| */","/g
endfu
