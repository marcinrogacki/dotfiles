# Extension

Plugins are loaded by https://github.com/tpope/vim-pathogen

## Android support

Several options are available, not all are working however listing them for
reference. 

### vim-android + ALE + java-language-server

Available features: check Java syntax, GoToDefinition, code completion,
auto-import, code formatting. Missing a fuzzy code completion which might be
implemented in future: https://github.com/dense-analysis/ale/issues/2208

Note, there is known bug in VIM: https://github.com/vim/vim/issues/8974 Unable
to view zip files (jar as well). That affects GoToDefinition command from ALE.
In addition a plugin https://github.com/bogado/file-line.git also affects
opening zip/jar files. Don't use it.

Install steps reference:
https://github.com/georgewfraser/java-language-server/pull/64#issuecomment-504544437

* Install vim-android https://github.com/hsanson/vim-android.git
    * Plugin will export CLASSPATH variable upon vim runtime. It will provide 
      information where to search imported java classes from Android SDK, 3rd 
      party libs and project it self.
    * Set in _.vimrc_ a path to Android SDK: `let g:android_sdk_path = "/opt/android-sdk"`
* Install https://github.com/georgewfraser/java-language-server
    * Required by ALE
    * Arch Linux package https://aur.archlinux.org/packages/java-language-server-git/
      FYI https://aur.archlinux.org/packages/java-language-server doesn't
 	  compile ATM, reference https://github.com/georgewfraser/java-language-server/issues/145
* Install ALE https://github.com/dense-analysis/ale
    * Provides syntax checking and semantic errors
    * Add to file  `~/.vim/after/ftplugin/java.vim`
    ```
    " Map a filetype to the command that starts the language server
    let g:ale_linters = {'java': ['checkstyle', 'javalsp', 'android']}
    let g:ale_java_javalsp_executable = 'java-language-server'
    " Press 'ctrl+]' to jump to function or variable definition
    nmap <C-]> :ALEGoToDefinition<cr>
    ```
* Install Deno  https://github.com/vim-denops/denops.vim
    * Required by DDC
    * Arch Linux package: `pacman -S deno`
* Install Denops https://github.com/vim-denops/denops.vim
    * Required by DDC
    * Install temporarily https://github.com/vim-denops/denops-helloworld.vim to
      test whether Denops works. Type vim command `:DenopsHello` to verify.
* Install DDC https://github.com/Shougo/ddc.vim#requirements
    * Fuzzy syntax completion
    * Optional dependency for ALE
    * Clone repository as usual. Pathogen will load plugin without problem
    * Add to file  `~/.vim/after/ftplugin/java.vim`
    ```
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
    ```
* Install ddc-ale https://github.com/statiolake/ddc-ale
    * ALE was implemented in mine to use Deoplete which is deprecated version
      of ddc. This plugin allows use ddc instead.
* Install checkstyle
    * A tool to help programmers write Java code that adheres to a coding standard 
    * Arch Linux package https://aur.archlinux.org/packages/checkstyle/
    * Optional dependency for ALE

### Syntastic + vim-android

Provides syntax checker, recognizes Android packages but I couldn't find a
GoToDefinition support.

* Install Syntastic https://github.com/vim-syntastic/syntastic
    * Enable javac support in _.vimrc_: `let g:syntastic_java_checkers=['javac']`
    * Plugin will provide syntax checker
* Install vim-android https://github.com/hsanson/vim-android.git
    * Plugin will export CLASSPATH variable for Syntastic which will allow inspect imports from Android, 3rd party libs and project itself
    * Set in _.vimrc_ a path to Android SDK: `let g:android_sdk_path = "/opt/android-sdk"`

### YouCompleteMe

Doesn't support Android packages. Can't be used.

* Install YCM https://github.com/ycm-core/YouCompleteMe
    * Arch Linux: https://wiki.archlinux.org/title/Vim/YouCompleteMe
    * Has a nice syntax fuzzy finder
