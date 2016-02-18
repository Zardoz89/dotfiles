" Color theme
set background=dark
syntax on

" Generic config ***************************************************************

" set cc=80 " Highlight column at 80
" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
  highlight ColorColumn ctermbg=red
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

" Color scheme
if ( !has("unix") && has("gui_running") )
  colors vividchalk
else
  colors darkblue
endif

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
set expandtab " Pressing <Tab> puts spaces, and < or > for indenting

" Display tabs and trailing spaces visually
set list listchars=tab:\↠\ ,trail:·

set splitright " Split vertically to the right.
set splitbelow " Split horizontally below.

set number " show line number
set ru " Ruler active

" Wildmenu
set wildmenu

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=15

" Status bar
set laststatus=2 " Seperate lines for state and mode<Paste>
set showmode " Show current mode in the status line.
set showcmd " Show the command in the status line.

" Fileformats
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown
autocmd FileType make set noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType md set expandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType xml setl noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType python set omnifunc=pythoncomplete#Complete


" OS and GVim/Vim/NVim stuff ***************************************************

" Correct paths for vim/nvim on windows&linux and colors
if !has("unix")
  " Vim/GVim Windows
  set nocompatible
  set t_Co=256            " 256 color mode in term
  let s:editor_root=expand("~/vimfiles")

else
  if has('nvim') " NVIM!
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True color!
    let s:editor_root=expand("~/.config/nvim")
  else " Vim/GVim on Unix
    set nocompatible
    set t_Co=256            " 256 color mode in term

    let s:editor_root=expand("~/.vim")
    let runtimepath= s:editor_root . ',' . '~/.neovim/,$VIMRUNTIME'
  endif
endif

if !has('nvim') || !has('unix')
  " Try to use Source Code  font
  set anti enc=utf-8
  if has("gui_running")
    if has("gui_gtk2")
      set guifont=Source\ Code\ Pro\ 10
    elseif has("gui_photon")
      set guifont=Source\ Code\ Pro:s10
    elseif has("gui_kde")
      set guifont=Source\ Code\ Pro/10/-1/5/50/0/0/0/1/0
    else
      set guifont=Source\ Code\ Pro:h10::cDEFAULT
    endif
  endif
endif

" Fix Windows stuff
if !has('unix')
  " ugly characters on menu and welcome screen
  set encoding=utf-8
  " backspace and cursor keys wrap to previous/next line
  set backspace=indent,eol,start whichwrap+=<,>,[,
endif

" NeoVim terminal
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif
" Switching of buffer
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Title
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term =~ "xterm" || &term =~ "nvim"
  set title
endif

" Vundle ***********************************************************************
let vundle_path=s:editor_root . '/bundle'
let &rtp = &rtp . ',' . vundle_path . '/vundle/'

" Autoinstall of vundle
" Source from http://arusahni.net/blog/2015/04/switching-to-neovim-part-2.html
let vundle_installed=1
let vundle_readme=vundle_path . '/vundle/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    " silent execute "! mkdir -p " . vundle_path
    silent call mkdir(vundle_path , "p")
    silent execute "!git clone https://github.com/gmarik/vundle " . vundle_path . '/vundle'
    let vundle_installed=0
endif

filetype off " required!
call vundle#begin(vundle_path)

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" Must have Plugins!
" Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig-vim'

" D Lang
Plugin 'idanarye/vim-dutyl'

" Web stuff
"Plugin 'pangloss/vim-javascript'
"Plugin 'https://github.com/hail2u/vim-css3-syntax.git'
"Plugin 'https://github.com/skammer/vim-css-color.git'
"Plugin 'groenewege/vim-less'

" Python
"Plugin 'python.vim'

" Markdown
Plugin 'https://github.com/tpope/vim-markdown.git'

" Git
Plugin 'https://github.com/tpope/vim-fugitive'

" Color theme
Plugin 'https://github.com/tpope/vim-vividchalk.git'
call vundle#end()            " required

filetype plugin indent on " required!

" Vundle ***********************************************************************

" Config Airline and status line
let g:smartusline_string_to_highlight = '(%n) %f '
set laststatus=2 " Seperate lines for state and mode
let g:airline_powerline_fonts=1 " Powerline simbols. Hermit font support it
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#syntastic#enabled=1

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = s:editor_root
" let g:ycm_global_ycm_extra_conf = vundle_path . '/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Ultimate Snips
let g:UltiSnipsExpandTrigger="<c-n>"

" Enable indent guides on boot and allow colorschemes to style them.
if ( !has("unix") && has("gui_running") )
  " GVim on Windows
  let g:indent_guides_enable_on_vim_startup=1
  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#202020' ctermbg=darkgrey
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#101010'
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



" Functions and remaps

" Trailing spaces stuff
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

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

" vim: set ts=2 sw=2 tw=78 et :