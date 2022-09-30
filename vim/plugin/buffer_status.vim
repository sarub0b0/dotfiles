let g:buffer_status = 1

if exists('g:buffer_status')
  finish
endif

let g:buffer_status = 1

let g:buffer_status_list = get(g:, 'buffer_status_list', [])

let g:buffer_status_disabled = 0


function! s:clear_list()
  for status in g:buffer_status_list
    call nvim_win_close(status.win, v:false)
    call nvim_buf_delete(status.buf, { 'force': v:true })
  endfor

  let g:buffer_status_list = []

endfunction

function! s:set_buffer_status()

  for id in range(1, winnr('$'))

    let type = win_getid(id)->win_gettype()
    if type != ''
      continue
    endif

    let win_id = win_getid(id)
    let bufname = win_id->winbufnr()->bufname()->fnamemodify(':~:.')

    if bufname =~ "coc-explorer"
      continue
    endif


    let bufname_len = strdisplaywidth(bufname)
    " echomsg 'number: ' . id . ' win_id: ' . win_getid(id) . ' type: ' . type . ' bufname: ' . bufname

    let buf = nvim_create_buf(v:false, v:true)


    call nvim_buf_set_lines(buf, 0, -1, v:true, [bufname])

    let winwidth = winwidth(win_id)

    let width = winwidth <= bufname_len ? winwidth - 2 : bufname_len

    " echomsg width

    let opts = {
        \ 'relative': 'win',
        \ 'win': win_id,
        \ 'height': 1,
        \ 'width': width,
        \ 'row': 0,
        \ 'col': winwidth - 0 ,
        \ 'anchor': 'NE',
        \ 'style': 'minimal',
        \ 'focusable': v:false,
        \ 'noautocmd': v:false,
        \ 'border': 'single'
        \ }


    let win = nvim_open_win(buf, v:false, opts)


    call nvim_win_set_option(win, 'winhl', "Normal:BufferStatus")

    call add(g:buffer_status_list, { 'win': win, 'buf': buf })

  endfor
endfunction

function! s:buffer_status_update()
  if g:buffer_status_disabled == 1
    return
  endif

  hi BufferStatus guifg=#fac863 guibg=#1b2b34

  call s:clear_list()

  call s:set_buffer_status()

endfunction

function! s:buffer_status_disable()
  let g:buffer_status_disabled = 1

  call s:clear_list()

endfunction



command! BufferStatusUpdate call s:buffer_status_update()
command! BufferStatusDisable call s:buffer_status_disable()

autocmd! BufRead,VimResized,WinNew,WinScrolled,WinClosed,TabNew,TabClosed * :BufferStatusUpdate
