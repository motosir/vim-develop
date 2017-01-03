" Develop:      Optimises vim work flow for developing new software.
" Motosir Ali:  Motosir Ali (http://noahfrederick.com)

if (exists('g:loaded_develop') && g:loaded_develop) || &cp
  finish
endif
let g:loaded_develop = 1

echom "loaded plugin"

"augroup vim-develop
"  autocmd!
"  autocmd BufNewFile * call s:load_maybe(expand('<amatch>'), '')
"  autocmd FileType   * call s:load_maybe(expand('<afile>'), expand('<amatch>'))
"augroup END
"
"
function! develop#BuildOrRun()
    echo "Build Or Run"
endfunction

command! -nargs=? BuildOrRun call develop#BuildOrRun(<f-args>)
