"" Plugin vim-android
" Tell where is android SDK. It will allow generate app/.classpath file
" properly for ALE
let g:android_sdk_path = expand("$ANDROID_HOME")
let g:gradle_loclist_show = 0
let g:gradle_show_signs = 0

"" Plugin: https://github.com/dense-analysis/ale
" Reason: Android development
" Reference: https://github.com/georgewfraser/java-language-server/pull/64#issuecomment-504544437
let g:ale_linters = {'kotlin': ['ktlint', 'languageserver', 'android']}
" Tell which command (or path) to use to run jls
let g:ale_kotlin_languageserver_executable = 'kotlin-language-server'
" Press 'ctrl+]' to jump to function or variable definition
nmap <C-]> :ALEGoToDefinition<cr>

"" Plugin: https://github.com/Shougo/ddc.vim
" Reason: Android development
" Reference: https://github.com/georgewfraser/java-language-server/pull/64#issuecomment-504544437
" Enable ALE
call ddc#custom#patch_global('sources', ['ale'])
" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ ddc#map#pum_visible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()
" <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'
" enable plugin
call ddc#enable()
