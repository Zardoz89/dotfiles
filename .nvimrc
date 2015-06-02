set nocompatible " Use Vim defaults (much better!)
set runtimepath=~/.neovim/,$VIMRUNTIME

syntax on

filetype off " required!
 
if !has("unix")
  " Vundle on Windows
  set rtp+=~/vimfiles/bundle/Vundle.vim/
  let path='~/vimfiles/bundle'
  call vundle#begin(path)
  set encoding=utf-8 " Should fix ugly characters on menu and welcome screen
else
  set rtp+=~/.neovim/bundle/vundle/
  call vundle#rc('~/.neovim/bundle')
endif

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Must have plugins!
Bundle 'Valloric/YouCompleteMe'
Bundle 'bling/vim-airline'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
Bundle 'editorconfig-vim'

" Web stuff
"Bundle 'pangloss/vim-javascript'
"Bundle 'https://github.com/hail2u/vim-css3-syntax.git'
"Bundle 'https://github.com/skammer/vim-css-color.git'
"Bundle 'groenewege/vim-less'

" Python
"Bundle 'python.vim'

" Markdown
"Bundle 'https://github.com/tpope/vim-markdown.git'

" Git
Bundle 'https://github.com/tpope/vim-fugitive'

" Color theme
Bundle 'https://github.com/tpope/vim-vividchalk.git'

filetype plugin indent on " required!

set t_Co=256 " 256 color mode in term

set autoread " ReaLoad a file if was changed outside of Vim
 
set cc=80 " Highlight column at 80
set wrap " Enable line wrapping.

" Use intelligent case while searching.
" If search string contains an upper case letter, disable ignorecase.
set smartcase
set incsearch " Incremental search
set hlsearch " Higlihts search results

" Identation
set autoindent " Copy indent from current line when starting a new line
set smarttab
set tabstop=2 " Number of space og a <Tab> character
set softtabstop=2
set shiftwidth=2 " Number of spaces use by autoindent
set expandtab " Pressing <Tab> puts spaces, and < and > for indenting uses psaces

" Commands execute automatically on an event

" Rules to disable expandtab in makefiles and markdown files
autocmd FileType make set noexpandtab nosta
autocmd FileType md set expandtab nosta

" autocmd FileType python set omnifunc=pythoncomplete#Complete

autocmd! bufwritepost cimrc source ~/.nvimrc

" Enables mice in terminal vim
"set mouse=a
"set mousem=popup " Enable the popup menu.

set splitright " Split vertically to the right.
set splitbelow " Split horizontally below.

set number " show line number
set ru " Ruler active

" Wildmenu
set wildmenu

" Complete options (disable preview scratch window)
" set completeopt=menu,menuone,longest
" Limit popup menu height
" set pumheight=15


" Config Airline and status line
let g:smartusline_string_to_highlight = '(%n) %f '
set laststatus=2 " Seperate lines for state and mode
let g:airline_powerline_fonts=1 " Powerline simbols. Hermit font support it
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#syntastic#enabled=1
set showmode " Show current mode in the status line.
set showcmd " Show the command in the status line.
" 
" " Try to use hermit font
" if has("gui_running")
"   if has("gui_gtk2")
"     set guifont=Hermit\ Medium\ 10
"   elseif has("gui_photon")
"     set guifont=Hermit:s10
"   elseif has("gui_kde")
"     set guifont=Hermit/10/-1/5/50/0/0/0/1/0
"   elseif has("x11")
"     set guifont=-*-hermitr-medium-r-normal-*-*-180-*-*-m-*-*
"   else
"     set guifont=Hermit:h10:cDEFAULT
"   endif
" endif
" 
" " YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '~/.neovim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
 
" Color theme
colors vividchalk
"colors darkblue

" Enable indent guides on boot and allow colorschemes to style them.
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#202020' ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#101010'

" Syntastic
set ofu=syntaxcomplete#Complete
let g:syntastic_mode_map={ 'mode': 'active',
\ 'active_filetypes': [],
\ 'passive_filetypes': ['html', 'cpp'] }
let g:syntastic_check_on_open=1

" Trailing spaces stuff
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" " Butterfly mode
" :command Butterfly :echo "amazing physics is going on"


" " Windows fix
" if !has("unix")
"   " backspace and cursor keys wrap to previous/next line
"   set backspace=indent,eol,start whichwrap+=<,>,[,
" else
"   set backspace=indent,eol,start
" endif

