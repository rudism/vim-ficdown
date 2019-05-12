function! ale_linters#ficdown#ficdown#ProcessOutput(buffer, lines) abort
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

function! ale_linters#ficdown#ficdown#GetExecutable(buffer) abort
  let s:exe_path = ''
  if !exists('g:ficdown_exe_path')
    let s:exe_path = 'ficdown.exe'
  else
    let s:exe_path = g:ficdown_exe_path
  endif

  return s:exe_path
endfunction

call ale#linter#Define('ficdown', {
\   'name': 'ficdown',
\   'aliases': ['Ficdown', 'FicDown'],
\   'executable_callback': 'ale_linters#ficdown#ficdown#GetExecutable',
\   'command': '%e --format lint',
\   'callback': 'ale_linters#ficdown#ficdown#ProcessOutput'
\})
