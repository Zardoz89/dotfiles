" font setup for gvim by luc

let s:fonts = [
      \ ['FuraCode Nerd Font',       10, 25],
      \ ['Fira Code',                10, 25],
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
  let g:GuiInternalClipboard = 1
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
  call rpcnotify(1, 'Gui', 'Font', 'FuraCode Nerd Font 10')
else                |
  Guifont! FuraCode Nerd Font:h10
endif

" Shift+Insert on neovim-gtk
if exists('g:GtkGuiLoaded')
  map <silent> <S-Insert> "+p
  imap <silent> <S-Insert> <Esc>"+pa
endif


