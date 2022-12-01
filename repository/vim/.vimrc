"" Enable profiling to find what slow downs the Vim
" profile start vimprofile.log
" profile func *
" profile file *

"" vim-pathogen.git
" Load plugin loader
runtime bundle/vim-pathogen.git/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

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
" Spell checker
set spelllang=en
set spell
" Set space for custom key mapping
let mapleader = "\<Space>"
" Autocomplete window behaviour:
" * popup - display floating window (balloon)
set completeopt=menu,menuone,popup

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

" Spell checker wrong word highlighting color
hi SpellBad ctermbg=88

" Search highlight color
hi Search cterm=NONE ctermfg=52 ctermbg=3

" Popup window color
hi Pmenu ctermbg=151 guibg=gray
hi PmenuSel ctermbg=8 ctermfg=2
" Set documentation popup at same hight (menu) as completion popup
set completepopup=align:menu,border:on,highlight:PmenuSel


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
map <C-s> :w <Enter>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Language specifics
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" graphql
" Indent by two spaces instead four
autocmd FileType graphql setlocal shiftwidth=2 softtabstop=2

" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" nerdtree.git
nmap <leader>t :NERDTreeFind<cr>
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
nmap <leader>b :TagbarOpenAutoClose<cr>

"" vim-airline.git
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_theme='papercolor'
" Extension slows greatly the vim on large files
let g:airline#extensions#tagbar#enabled = 0

"" https://github.com/ctrlpvim/ctrlp.vim.git
" Fuzzy finder for files.
" Use 'ag' instead 'grep' to boost serach performance.
if executable('ag')
  " Use Ag over Grep
  " set grepprg=ag\ --nogroup\ --nocolor\ -U\ --hidden
  " Use ag in ctrlp for listing files. Define ignore list in .ignore inside
  " the project
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -U -g ""'
else
  echom "the_silver_searcher (ag) is not installed. The ctrlp (file fuzzy finder) will not work as expected."
endif

"" https://github.com/ntpeters/vim-better-whitespace.git
" enable vim-better-whitespace.git plugin (removes whitespaces at EOL) on save
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
" Don't ask whether or not to strip white spaces
let g:strip_whitespace_confirm=0

"" vim-mark.git
" Remove the default overriding of * and #. Conflicts with IndexedSearch.vim
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
" Eye friendly mark color without yellow which is used for search highlight
let g:mwDefaultHighlightingPalette = [
\   { 'ctermbg':'21', 'ctermfg': 'White' },
\   { 'ctermbg':'23', 'ctermfg': 'White' },
\   { 'ctermbg':'43', 'ctermfg': 'Black' },
\   { 'ctermbg':'58', 'ctermfg': 'White' },
\   { 'ctermbg':'88', 'ctermfg': 'White' },
\   { 'ctermbg':'92', 'ctermfg': 'White' },
\   { 'ctermbg':'153', 'ctermfg': 'Black' },
\   { 'ctermbg':'163', 'ctermfg': 'Black' },
\   { 'ctermbg':'196', 'ctermfg': 'White' },
\   { 'ctermbg':'202', 'ctermfg': 'Black' },
\   { 'ctermbg':'216', 'ctermfg': 'Black' },
\   { 'ctermbg':'249', 'ctermfg': 'Black' },
\]

"" vim-markdown.git
" disable folding
let g:vim_markdown_folding_disabled = 1
" disable due conflicting personal mapping: <leader>r ALERename
let g:mw_no_mappings = 1
" keep useful mappings
nmap <unique> <Leader>m <Plug>MarkSet

"" Plugin https://github.com/dense-analysis/ale
" Usage: Android development, Typescript development
" Press 'ctrl+]' to jump to function or variable definition
nmap <C-]> :ALEGoToDefinition<cr>
" Go to  next lint error
nmap <leader>e :ALENext<cr>
" Go to  previous lint error
nmap <leader>E :ALEPrevious<cr>
" Show full lint error
nmap <leader>d :ALEDetail<cr>
" Execute lint
nmap <leader>l :ALELint<cr>
" Rename var
nmap <leader>r :ALERename<cr>
" Display notification about number of lint errors found in current file
let g:airline#extensions#ale#enabled = 1

"" https://github.com/Shougo/pum.vim
" Usage: Typescript
" Use TAB to trigger autocomplete. Highlight searched words in fuzzy
" autocomplete.
call ddc#custom#patch_global('completionMenu', 'pum.vim')
" <TAB>: start completion or go to next item
inoremap <silent><expr> <TAB>
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#pum_visible() ?
\ pum#map#insert_relative(+1) : ddc#map#manual_complete()
" <S-TAB>: completion previous item
inoremap <expr><S-TAB> ddc#map#pum_visible() ? pum#map#insert_relative(-1) : '<C-h>'
" <C-y>: accept completion item
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR> " <C-e>: accept completion item
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

"" Plugin: https://github.com/tani/ddc-fuzzy
" Usage: Typescript
" Autocompletion fuzzy matcher
call ddc#custom#patch_global('sourceOptions', {
\   '_': {
\     'matchers': ['matcher_fuzzy'],
\     'sorters': ['sorter_fuzzy'],
\     'converters': ['converter_fuzzy'],
\     'ignoreCase': 'true'
\   }
\ })

"" Plugin: https://github.com/Shougo/ddc.vim
" Usage: Android development, Typescript development
" Enable ALE
call ddc#custom#patch_global('sources', ['ale'])

" enable plugin
call ddc#enable()
