" Develop:      Optimises vim work flow for developing new software.
" Motosir Ali:  Motosir Ali (http://noahfrederick.com)

"if (exists('g:loaded_develop') && g:loaded_develop) || &cp
"  finish
"endif
"let g:loaded_develop = 1

" TODO: build and run cpp file/project, 
"  - need to check if there's a Makefile
"  - have option of compiling current translation unit 
"  - report errors back to location list
function! develop#BuildCpp(args)
        echo "Not implemented yet."
endfunction


" Will attempt to execute the current file based on the `&filetype`
" You need to manually map the filetypes you use most commonly to the
" correct shell command.
function! develop#ExecuteFile(args)
  let filetype_to_command = {
  \   'javascript': 'node',
  \   'coffee': 'coffee',
  \   'python': 'python',
  \   'html': 'open',
  \   'sh': 'bash'
  \ }
  let cmd = get(filetype_to_command, &filetype, &filetype)
  let cmd = cmd." % ".a:args
  call develop#RunShellCommand(cmd)
endfunction


" Thanks to: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
function! develop#RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  let s:last_win = winnr() 
"  let s:last_line = line('.')
"  let s:last_col = col('.')
  
  if !(exists('s:develop_buffer_created'))
      " create window and occupy full vim width
      botright 12new
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap 
      silent file [DevelopBuffer] 
      setlocal filetype=develop
      let s:develop_buffer_created = 1
      let s:develop_bufnr = bufnr('%')
      let line = 1
  else
      execute bufwinnr(s:develop_bufnr).'wincmd w'
      set modifiable
      let line = s:develop_line+1 
      call setline(line, "")
      let line = line +1
  endif
  
"  call setline(1, 'You entered:    ' . a:cmdline)
"  let outhdr1 = 'Cmd:  ' .expanded_cmdline
"  let outhdr2 = substitute(outhdr1,'.','=','g')
  call setline(line, "~$ ".expanded_cmdline)

  silent execute '$read !'. expanded_cmdline

  "store line for next run
  let s:develop_line = line('.')
  setlocal nomodifiable
  "jump back to last window
  execute s:last_win.'wincmd w'
endfunction

