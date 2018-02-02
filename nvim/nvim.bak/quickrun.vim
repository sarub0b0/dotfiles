let g:quickrun_config = get(g:, 'quickrun_config', {})

let g:quickrun_config['_'] = {
            \   'runner': 'vimproc',
            \   'runner/vimproc/updatetime': 60,
            \   'outputter': 'error',
            \   'outputter/error/success': 'buffer',
            \   'outputter/error/error': 'quickfix',
            \   'outputter/buffer/close_on_empty': 1,
            \   'outputter/buffer/split': 'rightbelow 7',
            \   }

let g:quickrun_config['allegro'] = {
            \      'command': 'clang',
            \      'cmdopt': '`pkg-config --cflags --libs allegro-5 allegro_acodec-5 allegro_audio-5 allegro_color-5 allegro_dialog-5 allegro_font-5 allegro_image-5 allegro_main-5 allegro_memfile-5 allegro_physfs-5 allegro_primitives-5 allegro_ttf-5`',
            \      'exec': '%c %o %s:p',
            \       }


nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

let g:quickrun_no_default_key_mappings = 1
nnoremap <Leader>r :cclose<CR>:write<CR>:QuickRun<Space>
xnoremap <Leader>r :<C-U>cclose<CR>:<C-U>write<CR>gv:QuickRun<Space>
