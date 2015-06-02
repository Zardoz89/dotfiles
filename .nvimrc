set nocompatible " Use Vim defaults (much better!)

" Color theme
set t_Co=256            " 256 color mode in term
set background=dark
syntax on
if ( !has("unix") && has("gui_running") )
  colors vividchalk
else
  colors darkblue
endif

filetype off " required!

if !has("unix")
  " Vundle on Windows
  set rtp+=~/vimfiles/bundle/Vundle.vim/
  let path='~/vimfiles/bundle'
  call vundle#begin(path)
  set encoding=utf-8 " Should fix ugly characters on menu and welcome screen
else
  set runtimepath=~/.neovim/,$VIMRUNTIME
  set rtp+=~/.neovim/bundle/vundle/
  call vundle#rc('~/.neovim/bundle')
endif

" Stop Vim dying if there's massively long lines.
set synmaxcol=128

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
Bundle 'https://github.com/tpope/vim-markdown.git'

" Git
Bundle 'https://github.com/tpope/vim-fugitive'

" Color theme
Bundle 'https://github.com/tpope/vim-vividchalk.git'

filetype plugin indent on " required!

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
autocmd FileType xml setl noexpandtab nosta sw=4 sts=4 tabstop=4

autocmd FileType python set omnifunc=pythoncomplete#Complete

if !has("unix")
  autocmd! bufwritepost cimrc source ~/_vimrc
else
  autocmd! bufwritepost cimrc source ~/.nvimrc
endif

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
if ( !has("unix") && !has("gui_running") )
  let g:airline_left_sep='>'                   " If we use a font without support of powerline simbols
  let g:airline_right_sep='<'
endif
set showmode " Show current mode in the status line.
set showcmd " Show the command in the status line.

" Try to use Source Code  font
set anti enc=utf-8
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Sauce\ Code\ Powerline\ 10
  elseif has("gui_photon")
    set guifont=Sauce\ Code\ Powerline:s10
  elseif has("gui_kde")
    set guifont=Sauce\ Code\ Powerline/10/-1/5/50/0/0/0/1/0
  else
    set guifont=Sauce\ Code\ Powerline:h10::cDEFAULT
  endif
endif

" YouCompleteMe
if !has("unix")
  let g:ycm_global_ycm_extra_conf = '~/_vim/'
else
  let g:ycm_global_ycm_extra_conf = '~/.nvim/'
" let g:ycm_global_ycm_extra_conf = '~/.neovim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
endif

" Enable indent guides on boot and allow colorschemes to style them.
if ( !has("unix"))
  if ( has("gui_running") )
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#202020' ctermbg=darkgrey
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#101010'
  endif
else
  let g:indent_guides_enable_on_vim_startup=1
  let g:indent_guides_auto_colors = 1
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#202020' ctermbg=darkgrey
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#101010'
endif

" Syntastic
set ofu=syntaxcomplete#Complete
let g:syntastic_mode_map={ 'mode': 'active',
\ 'active_filetypes': [],
\ 'passive_filetypes': ['html', 'cpp'] }
let g:syntastic_check_on_open=1

" Trailing spaces stuff
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Windows fix
if !has("unix")
  " backspace and cursor keys wrap to previous/next line
  set backspace=indent,eol,start whichwrap+=<,>,[,
" else
"   set backspace=indent,eol,start
endif

