" Generic config ***************************************************************ir

syntax on

" Color mode
if (has("termguicolors"))
  set termguicolors       " TrueColor!
else
  set t_Co=256            " 256 color mode in term
endif

let mapleader = "," " Useful leader on Spanish keyboard

set wrap " Enable line wrapping.

" Use intelligent case while searching.
" If search string contains an upper case letter, disable ignorecase.
set smartcase
set incsearch " Incremental search
set hlsearch " Higlihts search results

" Identation
set autoindent " Copy indent from current line when starting a new line
set copyindent
set smarttab
set tabstop=2 " Number of space og a <Tab> character
set softtabstop=2
set shiftwidth=2 " Number of spaces use by autoindent
set shiftround " round indent to multiple of 'shiftwidth'
set expandtab " Pressing <Tab> puts spaces, and < or > for indenting

" Display tabs and trailing spaces visually
set list listchars=tab:‣\ ,nbsp:␣,extends:▶,trail:·,eol:¶
let &showbreak = '↳ '"'←'

set hidden     " Not close buffer, only hide it
set splitright " Split vertically to the right.
set splitbelow " Split horizontally below.

set pastetoggle=<F2> " Use F2 to do Ctrl+V from console

set number " show line number
set ru " Ruler active

" Folding
set foldmethod=syntax
set nofoldenable

" Wildmenu
set wildmenu

" Complete options (disable preview scratch window)
"set completeopt=menu,menuone,longest
" Limit popup menu height
"set pumheight=15

" Status bar
set laststatus=2 " Seperate lines for state and mode
set showmode " Show current mode in the status line.
set showcmd " Show the command in the status line.
set cmdheight=2 "Better display for messages
set updatetime=300

" Show vertical guides at 80 and 120, highlight characters that go over 120 columns (by drawing a border on the 121st)
set colorcolumn=80,120

set mouse=a

" Only show cursorline in the current window and in normal mode {{{2
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END


" Fileformats
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown
autocmd FileType make setlocal noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType markdown call SetMarkdownOptions()
" If overwrite the SetMarkDownOptions function if it exists
function! SetMarkdownOptions()
  setlocal expandtab
  setlocal nosta
  setlocal sw=4
  setlocal sts=4
  setlocal tabstop=4
  setlocal textwidth=79
  setlocal colorcolumn=80
  setlocal spell spelllang=en_us
  setlocal noshiftround
endfunction
autocmd FileType xml setlocal noexpandtab nosta sw=4 sts=4 tabstop=4 omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType css,less,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" // and /* */ as comments on JSON or pseudo JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

" Add spell check to git commits
autocmd FileType gitcommit setlocal spell spelllang=es_es

" OS and GVim/Vim/NVim stuff ***************************************************

" Correct paths for vim/nvim on windows&linux and colors
if has('nvim') " NVIM!
  let s:editor_root=expand("~/.config/nvim")
else " VIM/GVIM
  set nocompatible
  if !has("unix")
    " Vim/GVim Windows
    let s:editor_root=expand("~/vimfiles")

    " Try to use Fira Code  font
    set anti enc=utf-8
    if has("gui_running")
      if has("gui_gtk2")
        set guifont=Fira\ Code\ 10
      else
        set guifont=Fira\ Code:h10::cDEFAULT
      endif
    endif

    " Fix Windows stuff
    " ugly characters on menu and welcome screen
    set encoding=utf-8
    " backspace and cursor keys wrap to previous/next line
    set backspace=indent,eol,start whichwrap+=<,>,[,

  else " Vim/GVim on Unix
    let s:editor_root=expand("~/.vim")
    let runtimepath= s:editor_root . ',' . ',$VIMRUNTIME'
  endif
endif

" Config permanet undo files and backup storage
" if has('persistent_undo')
"   let undo_path=s:editor_root . '/undodir'
"   " Ensure all needed directories exist
"   if empty(glob(undo_path . '/'))
"     call mkdir(undo_path, "p")
"   endif
"   let &undodir = undo_path
"   set undofile
"   set undolevels=1000
"   set undoreload=10000
" 
"   set backupdir=.,~/.local/share/nvim/backup,$TEMP,$TMP
"   "./.backup,.,$TEMP,$TMP
"   set directory=.,./.swp,$TEMP,$TMP
" endif
set backupcopy=yes

" Title
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term =~ "xterm" || &term =~ "nvim"
  set title
endif

" Vim-plug *********************************************************************
let plugged_path=s:editor_root . '/plugged'
" Load vim-plug
if empty(glob(s:editor_root . '/autoload/plug.vim'))
  " Ensure all needed directories exist  (Thanks @kapadiamush)
  call mkdir(plugged_path, "p")
  call mkdir(s:editor_root . '/autoload', "p")
  " Download the actual plugin manager
  execute '!curl -fLo ' . s:editor_root . '/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin(plugged_path)

" Load all plugins
execute 'source ' . s:editor_root . '/plugins.vim'

" ******************************************************************************

" Terminal stuff
if has('nvim')
  set shell=/usr/bin/fish
  autocmd TermOpen * startinsert
endif

" NERD tree
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=1
let NERDTreeNaturalSort=1
let NERDTreeChDirMode=1
noremap <silent> <leader>n :NERDTreeToggle<CR> <C-w>=
noremap <silent> <leader>f :NERDTreeFind<CR> <C-w>=

function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Config Airline and status line
set statusline+=\ %{&bomb?'BOM':''}
let g:smartusline_string_to_highlight = '(%n) %f '
set laststatus=2 " Seperate lines for state and mode
let g:airline_powerline_fonts=1 " Powerline simbols. Hermit font support it
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#format = 2

" JavaScript & JDoc
let g:javascript_plugin_jsdoc = 1
" Java Syntax colors
let java_highlight_functions = 1

" Enable indent guides on boot and allow colorschemes to style them.
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=bg
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#0B0D0E' ctermbg=darkgrey

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" Load all Coc config and mapping stuff
execute 'source ' . s:editor_root . '/coc-config.vim'

" Functions and remaps
command! WQ wq
command! Wq wq
command! W w
command! Q q

" black hole
map <leader>b "_
" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" Ctrl-S to save file
nmap <C-s> :w<CR>
vmap <C-s> <Esc><c-s>gv
imap <C-s> <Esc><c-s>
" Ctrl-R to reload actual file
nmap <C-r> :e<CR>

" NeoVim terminal
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

" Wrap visual navigation
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>

" arrow keys for buffer switching
" Shift+Up = Select buffer from list
" Shift+Down = Last-used buffer
" Shift+Left = Previous buffer
" Shift+Right = Next buffer
nnoremap <S-Up>     :buffers<cr>:buffer
nnoremap <S-Down>   :b#<cr>
nnoremap <S-Left>   :bp<cr>
nnoremap <S-Right>  :bn<cr>
nnoremap <Leader>c  :ene<CR>:bw #<CR>

" Window navigation
nnoremap <Leader><Up>     <C-W><Up>
nnoremap <Leader><Down>   <C-W><Down>
nnoremap <Leader><Left>   <C-W><Left>
nnoremap <Leader><Right>  <C-W><Right>

" Trailing spaces & Remove tabs stuff
nnoremap <silent> <Leader>tl :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <Leader>rt :let _s=@/<Bar>:%s/\t/    /g<CR>:let @/=_s<Bar>:nohl<CR>

" Debug syntax
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Show list of keybindings
nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR><Paste>

" Keep selected block when change indentation level
vnoremap < <gv
vnoremap > >gv

" Try to auto set encoding for working with old 8bit encodings
function! CheckFileEncoding()
  if exists('b:fenc_at_read') && &fileencoding != b:fenc_at_read
    exec 'e! ++enc=' . &fileencoding
    unlet b:fenc_at_read
  endif
endfunction
au BufRead     *.txt let b:fenc_at_read=&fileencoding
au BufWinEnter *.txt call CheckFileEncoding()
au BufRead     *.prg let b:fenc_at_read=&fileencoding
au BufWinEnter *.prg call CheckFileEncoding()
au BufRead     *.csv let b:fenc_at_read=&fileencoding
au BufWinEnter *.csv call CheckFileEncoding()
au BufRead     *.cpp let b:fenc_at_read=&fileencoding
au BufWinEnter *.cpp call CheckFileEncoding()
au BufRead     *.h let b:fenc_at_read=&fileencoding
au BufWinEnter *.h call CheckFileEncoding()
au BufRead     makefile let b:fenc_at_read=&fileencoding
au BufWinEnter makefile call CheckFileEncoding()


" Setup color scheme
syntax enable
set background=dark
try
  "colorscheme night-owl
  colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
  colors darkblue   " Fallback to darkblue
endtry

" This must be AFTER setting color scheme
" Override colorcolumn color and add overlength when the line is over 120 characters
highlight ColorColumn ctermbg=red ctermfg=white guibg=#351818
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" Fix anoying bug hanging nvim with the external USB driver automount
set shada+=r/mnt/backup
set shada+=r/mnt/dgb

" vim: set ts=2 sw=2 tw=78 et :
