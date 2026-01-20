set mouse=a


" Fix shift+i
inoremap <silent>  <S-Insert>  <C-R>+

GuiFont FiraCode Nerd Font Mono Ret:h10
 
GuiScrollBar 1
GuiRenderLigatures 1
GuiTabline 1
GuiTablineBuffers 1

"   GuiPopupmenu 0

 
" Trying menu
menu File.Save :w<CR>
inoremenu File.Save :w<CR>
amenu File.Next :next^M
