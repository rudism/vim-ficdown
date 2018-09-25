function! ale_linters#markdown#ficdown#ProcessOutput(buffer, lines) abort
  let l:pattern = '^\(\w\)\w\+ L\(\d\+\),\(\d\+\): \("[^"]\+": \)\?\(.\+\)$'
  let l:output = []

  for l:match in ale#util#GetMatches(a:lines, l:pattern)
    call add(l:output, {
    \   'type': l:match[1],
    \   'lnum': l:match[2] + 0,
    \   'col': l:match[3] + 0,
    \   'text': l:match[5]
    \})
  endfor

  return l:output
endfunction

function! ale_linters#markdown#ficdown#GetCommand(buffer) abort
  let s:exe_path = ''
  if !exists('g:ficdown_exe_path')
    let s:exe_path = 'ficdown.exe'
  else
    let s:exe_path = g:ficdown_exe_path
  endif

  return '%e ' . s:exe_path . ' --format lint'
endfunction

call ale#linter#Define('markdown', {
\   'name': 'ficdown',
\   'aliases': ['Ficdown', 'FicDown'],
\   'executable': 'mono',
\   'command_callback': 'ale_linters#markdown#ficdown#GetCommand',
\   'callback': 'ale_linters#markdown#ficdown#ProcessOutput'
\})
