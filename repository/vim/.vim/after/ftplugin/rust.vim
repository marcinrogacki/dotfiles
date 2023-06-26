let g:ale_linters = {
  \ 'rust': ['analyzer'],
  \ }
let b:ale_fixers = {
  \ 'rust': ['rustfmt'],
  \ }
" Disable error highlighting. Unnecessary clutter.
let g:ale_set_highlights = 0
" Format code on save
let g:ale_fix_on_save = 1
" Workaround for not working rustfmt.
" Do 'cargo install cargo-get' to install required soft.
" https://github.com/dense-analysis/ale/issues/3814
let b:rust_edition_command = 'cargo get --edition --root ' . bufname("%") . ' 2>/dev/null'
let b:rust_edition = trim(system(b:rust_edition_command))
if v:shell_error == 0 && len(b:rust_edition) > 0
  let g:ale_rust_rustfmt_options = '--edition ' .. b:rust_edition
else
  echom 'A rustfmt will not work. Failed determine Rust edition with command: ' .. b:rust_edition_command
endif
