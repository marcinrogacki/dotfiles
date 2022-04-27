" Indent by two spaces instead four
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

" tsserver enables GoToDefinition and code completion
" eslint enables code standards checking
let g:ale_linters = {'typescript': ['tsserver', 'eslint']}

" Auto format on save using prettier
let g:ale_fixers = {'typescript': ['prettier']}
let g:ale_fix_on_save = 1
