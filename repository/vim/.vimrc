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

" Use space for custom key mapping
let mapleader = "\<Space>"

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
" How long text will be with auto formatting via q command
set textwidth=120
" Enable code folding https://vim.fandom.com/wiki/Folding#Syntax_folding
set foldmethod=syntax
" By default open all folds
set foldlevel=99
" Fuzzy command-line completion
set wildoptions+=fuzzy

" Spell checker
if !&diff
  set spelllang=en
  set spell
endif

set completeopt=menu,menuone

" Appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set cursorcolumn
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
hi Search cterm=none ctermfg=52 ctermbg=3

" Popup window color
hi Pmenu ctermbg=151 guibg=gray
hi PmenuSel ctermbg=8 ctermfg=2

"" Vimdiff better color palette
highlight DiffAdd cterm=none ctermfg=darkgreen ctermbg=none
highlight DiffDelete cterm=none ctermfg=darkred ctermbg=none
highlight DiffChange cterm=none ctermfg=none ctermbg=none
highlight DiffText cterm=none ctermfg=darkgreen ctermbg=none

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
\   { 'ctermbg':'25', 'ctermfg': 'Black' },
\   { 'ctermbg':'27', 'ctermfg': 'White' },
\   { 'ctermbg':'39', 'ctermfg': 'White' },
\   { 'ctermbg':'57', 'ctermfg': 'White' },
\   { 'ctermbg':'63', 'ctermfg': 'White' },
\   { 'ctermbg':'97', 'ctermfg': 'White' },
\   { 'ctermbg':'139', 'ctermfg': 'White' },
\   { 'ctermbg':'22', 'ctermfg': 'White' },
\   { 'ctermbg':'29', 'ctermfg': 'White' },
\   { 'ctermbg':'36', 'ctermfg': 'Black' },
\   { 'ctermbg':'40', 'ctermfg': 'Black' },
\   { 'ctermbg':'43', 'ctermfg': 'Black' },
\   { 'ctermbg':'58', 'ctermfg': 'Black' },
\   { 'ctermbg':'64', 'ctermfg': 'Black' },
\   { 'ctermbg':'83', 'ctermfg': 'Black' },
\   { 'ctermbg':'172', 'ctermfg': 'Black' },
\   { 'ctermbg':'178', 'ctermfg': 'White' },
\   { 'ctermbg':'209', 'ctermfg': 'White' },
\   { 'ctermbg':'214', 'ctermfg': 'Black' },
\   { 'ctermbg':'220', 'ctermfg': 'Black' },
\   { 'ctermbg':'175', 'ctermfg': 'Black' },
\   { 'ctermbg':'182', 'ctermfg': 'Black' },
\   { 'ctermbg':'190', 'ctermfg': 'Black' }
\]

"" vim-markdown.git
" disable folding
let g:vim_markdown_folding_disabled = 1
" disable due conflicting personal mapping: <leader>r ALERename
let g:mw_no_mappings = 1
" keep useful mappings
nmap <unique> <Leader>m <Plug>MarkSet

"" https://github.com/github/copilot.vim
" Don't use <Tab> to accept Github copilot suggestion.
let g:copilot_no_tab_map = v:true
" Remap keys to use Alt+Key letter
imap <silent><script><expr> <M-Space> copilot#Accept("")
imap <M-Backspace> <Plug>(copilot-dismiss)
imap <M-]> <Plug>(copilot-next)
imap <M-[> <Plug>(copilot-previous)
imap <M-\> <Plug>(copilot-suggest)

"" Plugin https://github.com/dense-analysis/ale
" Tags: Android development, Typescript development
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

"" https://github.com/neoclide/coc.nvim
" Tags: Rust, autocomplete, inline docs
" Do "yarn install --frozen-lockfile" in coc.nvim directory. Install node bin.
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(0) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(0) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

"" https://github.com/tveskag/nvim-blame-line
" Tags: Git
" Show git blame for given line
nnoremap <silent> <leader>g :ToggleBlameLine<CR>
" Show blame info below the statusline instead of using virtual text
let g:blameLineUseVirtualText = 0
" Format: ISO date, author name, commit hash, commit message
let g:blameLineGitFormat = '%aI %an %h %s'

"" https://github.com/altercation/vim-colors-solarized?tab=readme-ov-file
" Monotones colorscheme
" Tags: vim
" Notes: Apply also Solarized color theme for terminal via .Xresources
" Dark theme
set background=dark
" Hight contrast for comments since they are less visible
let g:solarized_contrast="high"
" Darker and nicer looking background (does not look like original Soralized)
let g:solarized_termcolors=256
" Enable transparent background for urxvt
let g:solarized_termtrans=1
" enable, must be done last otherwise background is not transparent
colorscheme solarized
