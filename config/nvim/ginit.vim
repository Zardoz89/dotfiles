" font setup for gvim by luc

let s:fonts = [
      \ ['Fira Code',                     10, 25],
      \ ['Hack',                     10, 25],
      \ ['Source Code Pro',          10, 25],
      \ ['Monospace',                10, 25],
      \ ['inconsolata',              14, 30],
      \ ['dejavu sans mono',         12, 20]
      \ ]

" let s:delim = ''
" if has('gui_macvim')
"   let s:delim = ':h'
" elseif has('gui_gtk2') || exists('g:GtkGuiLoaded')
"   let s:delim = ' '
" endif
"
" let g:luc#gui#normalfonts = join(map(copy(s:fonts),
"       \ 'join(v:val[0:1], s:delim)'), ',')
" let g:luc#gui#bigfonts = join(map(copy(s:fonts),
"       \ '(remove(v:val, 1) . join(v:val, s:delim))[2:-1]'), ',')
"
" let &guifont = g:luc#gui#normalfonts

if exists('g:GtkGuiLoaded') " neovim-gtk
  call rpcnotify(1, 'Gui', 'Font', s:fonts[0][0].' '.s:fonts[0][1])
  let g:GuiInternalClipboard = 1
else                |
command -nargs=? Guifont call luc#gui#nvim_qt_guifont(<q-args>)
  augroup LucNvimGUIFont
    autocmd VimEnter *
      \ if has('nvim') && has('gui_running')                |
      \   execute 'Guifont' s:fonts[0][0].':h'.s:fonts[0][1] |
      \ endif
  augroup END
endif
