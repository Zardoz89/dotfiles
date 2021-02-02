" foot setup for gvim by luc

let s:fonts = [
      \ ['FuraCode Nerd Font',       10],
      \ ['Fira Code',                10],
      \ ['Hack',                     10],
      \ ['Source Code Pro',          10],
      \ ['Monospace',                10],
      \ ['inconsolata',              11],
      \ ['dejavu sans mono',         11]
      \ ]

" Disable anoying GUI tabline
call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

" Fix shift+i
inoremap <silent>  <S-Insert>  <C-R>+

if exists('g:fvim_loaded')
  " good old 'set guifont' compatibility
  set guifont= s:fonts[0][0] . ":h" . s:fonts[0][1] 
  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

elseif exists('g:GtkGuiLoaded') " neovim-gtk
  let g:GuiInternalClipboard = 1
  call rpcnotify(1, 'Gui', 'Font', s:fonts[0][0] . " " . s:fonts[0][1])

else " neovim-qt
  let s:setFont = 'GuiFont! ' . s:fonts[0][0] . ":h" . s:fonts[0][1]
  execute s:setFont
endif

" Shift+Insert on neovim-gtk
if exists('g:GtkGuiLoaded')
  map <silent> <S-Insert> "+p
  imap <silent> <S-Insert> <Esc>"+pa
endif

" Trying menu
menu File.Save :w<CR>
inoremenu File.Save :w<CR>
amenu File.Next :next^M
