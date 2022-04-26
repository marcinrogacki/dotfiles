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
