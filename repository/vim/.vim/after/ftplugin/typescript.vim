" Indent by two spaces instead four
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

" Tsserver enables GoToDefinition and code completion
let g:ale_linters = {'typescript': ['tsserver']}

" Auto format on save using prettier
let g:ale_fixers = {'typescript': ['prettier']}
let g:ale_fix_on_save = 1
