" Develop:      Optimises vim work flow for developing new software.
" Motosir Ali:  Motosir Ali (http://noahfrederick.com)

if (exists('g:loaded_develop') && g:loaded_develop) || &cp
  finish
endif
let g:loaded_develop = 1

"augroup vim-develop
"  autocmd!
"  autocmd BufNewFile * call s:load_maybe(expand('<amatch>'), '')
"  autocmd FileType   * call s:load_maybe(expand('<afile>'), expand('<amatch>'))
"augroup END
"


function! develop#BuildOrRun(...)
    let args = join(a:000, " ")
    if &ft == 'python'
        call develop#ExecuteFile(args) 
    elseif &ft == 'sh'
        call develop#ExecuteFile(args) 
    elseif &ft == 'sh'
        call develop#BuildCpp(args) 
    else
        echo &ft
    endif    
endfunction

command! -nargs=? BuildOrRun call develop#BuildOrRun(<f-args>)
command! -nargs=* -bang Drun call develop#BuildOrRun(<f-args>)
"command! -nargs=? BuildOrRun call develop#BuildOrRun(<f-args>)


"function! develop#BuildCpp(args)
"        echo "Detected ft=cpp"
"endfunction
"
"" Will attempt to execute the current file based on the `&filetype`
"" You need to manually map the filetypes you use most commonly to the
"" correct shell command.
"function! develop#ExecuteFile(args)
"  let filetype_to_command = {
"  \   'javascript': 'node',
"  \   'coffee': 'coffee',
"  \   'python': 'python',
"  \   'html': 'open',
"  \   'sh': 'bash'
"  \ }
"  let cmd = get(filetype_to_command, &filetype, &filetype)
"  let cmd = cmd." % ".a:args
"  call develop#RunShellCommand(cmd)
"endfunction
"
"
"" Thanks to: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
"function! develop#RunShellCommand(cmdline)
"  echo a:cmdline
"  let expanded_cmdline = a:cmdline
"  for part in split(a:cmdline, ' ')
"     if part[0] =~ '\v[%#<]'
"        let expanded_part = fnameescape(expand(part))
"        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
"     endif
"  endfor
"  let s:last_win = winnr() 
""  let s:last_line = line('.')
""  let s:last_col = col('.')
"  
"  if !(exists('s:develop_buffer_created'))
"      " create window and occupy full vim width
"      botright 12new
"      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap 
"      silent file [DevelopBuffer] 
"      let s:develop_buffer_created = 1
"      let s:develop_bufnr = bufnr('%')
"      let line = 0
"  else
"      execute bufwinnr(s:develop_bufnr).'wincmd w'
"      set modifiable
"      let line = s:develop_line+1 
"  endif
"  
""  call setline(1, 'You entered:    ' . a:cmdline)
"  let outhdr1 = 'Cmd:  ' .expanded_cmdline
"  let outhdr2 = substitute(outhdr1,'.','=','g')
"  call setline(line, outhdr1)
"  call setline(line+1, outhdr2) 
"
"  silent execute '$read !'. expanded_cmdline
"
"  "store line for next run
"  let s:develop_line = line('.')
"  setlocal nomodifiable
"  "jump back to last window
"  execute s:last_win.'wincmd w'
"endfunction
