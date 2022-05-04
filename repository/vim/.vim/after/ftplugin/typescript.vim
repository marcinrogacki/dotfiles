" Indent by two spaces instead four
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

" tsserver enables GoToDefinition and code completion
" eslint enables code standards checking
let g:ale_linters = {'typescript': ['tsserver', 'eslint']}

" Auto format on save using prettier
let g:ale_fixers = {'typescript': ['prettier']}

" Run lint only on save
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" Run prettier on save
let g:ale_fix_on_save = 1

" Improve performance of eslint
let g:ale_typescript_eslint_executable = 'eslint_d --cache'
