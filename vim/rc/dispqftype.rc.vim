
command! -nargs=0 DispQfType    call <SID>DispQfType()

function! s:DispQfType()
    let l:type = s:GetQfType()
    redraw
    if l:type ==# 'L'
        echo 'This window is Location List.'
        return 0
    elseif l:type ==# 'Q'
        echo 'This window is Quickfix List.'
        return 1
    else
        echo 'This window is not Location List or Quickfix List.'
        return 2
    endif
endfunction

function! s:GetQfType()
    if getwinvar(0, '&buftype') ==# 'quickfix'
        try
            let l:ret = 'L'
            let l:save_winnr = winnr()
            let l:wrcmd = winrestcmd()
            let l:wsv = winsaveview()
            lopen
            if winnr() != l:save_winnr
                lclose
                exe l:save_winnr . 'wincmd w'
                exe l:wrcmd
                let l:ret = 'Q'
            endif
            call winrestview(l:wsv)
            return l:ret
        catch /E776/
            return 'Q'
        endtry
    else
        return ''
    endif
endfunction
