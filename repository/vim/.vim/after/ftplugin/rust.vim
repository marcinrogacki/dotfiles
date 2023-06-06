let g:ale_linters = {
  \ 'rust': ['analyzer'],
  \ }
let g:ale_fixers = {
  \ 'rust': ['rustfmt'],
  \ }
" Format code on save
let g:ale_fix_on_save = 1
