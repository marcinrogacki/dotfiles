" Indent by two spaces instead four
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

" tsserver enables GoToDefinition and code completion
" eslint enables code standards checking
let g:ale_linters = {'typescript': ['tsserver', 'eslint']}

" Auto format on save using prettier
let g:ale_fixers = {'typescript': ['prettier']}

" eslint is slow
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

" Highlights are messed when using GoToDefinition. There are still signs.
let g:ale_set_highlights = 0
