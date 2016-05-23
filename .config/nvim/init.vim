" Generic config ***************************************************************

syntax on

" Color mode
set t_Co=256            " 256 color mode in term
set termguicolors       " TrueColor!

let mapleader = "," " Useful leader on Spanish keyboard

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

set hidden     " Not close buffer, only hide it

set splitright " Split vertically to the right.
set splitbelow " Split horizontally below.

set pastetoggle=<F2> " Use F2 to do Ctrl+V from console

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

" set cc=80 " Highlight column at 80
" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
  highlight ColorColumn ctermbg=red
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

" Only show cursorline in the current window and in normal mode {{{2
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END


" Fileformats
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown
autocmd FileType make set noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType md set expandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType xml setl noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType python set omnifunc=pythoncomplete#Complete

" OS and GVim/Vim/NVim stuff ***************************************************

" Correct paths for vim/nvim on windows&linux and colors
if has('nvim') " NVIM!
  let s:editor_root=expand("~/.config/nvim")
else " VIM/GVIM
  set nocompatible
  if !has("unix")
    " Vim/GVim Windows
    let s:editor_root=expand("~/vimfiles")

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


" Title
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term =~ "xterm" || &term =~ "nvim"
  set title
endif

" Vundle ***********************************************************************
let vundle_path=s:editor_root . '/vundle'
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
if !has('nvim')
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'rdnetto/YCM-Generator'
else
  Plugin 'Shougo/deoplete.nvim'
endif
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/syntastic'
Plugin 'editorconfig-vim'

" D Lang
if !has('nvim')
  Plugin 'idanarye/vim-dutyl'
else
  Plugin 'landaire/deoplete-d'
endif

" Web stuff
"Plugin 'pangloss/vim-javascript'
"Plugin 'https://github.com/hail2u/vim-css3-syntax.git'
Plugin 'https://github.com/skammer/vim-css-color.git'
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

" Deoplete async autocomplete
let g:deoplete#enable_at_startup = 1

" Functions and remaps

" NeoVim terminal
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

" arrow keys for buffer switching
" Shift+Up = Select buffer from list
" Shift+Down = Last-used buffer
" Shift+Left = Previous buffer
" Shift+Right = Next buffer
nnoremap <S-Up>     :buffers<cr>:buffer
nnoremap <S-Down>   :b#<cr>
nnoremap <S-Left>   :bp<cr>
nnoremap <S-Right>  :bn<cr>

"Resize splits automatically
function! Splitresize()
    let hmax = max([winwidth(0), 82])
    let vmax = max([winheight(0), float2nr(&lines*0.60), 25])
    exe "vertical resize" . (min([hmax, 140]))
    exe "resize" . (min([vmax, 60]))
endfunction

" Window navigation
nnoremap <Leader><Up> <C-W><Up>:call Splitresize()<cr>
nnoremap <Leader><Down> <C-W><Down>:call Splitresize()<cr>
nnoremap <Leader><Left> <C-W><Left>:call Splitresize()<cr>
nnoremap <Leader><Right> <C-W><Right>:call Splitresize()<cr>

" Trailing spaces & Remove tabs stuff
nnoremap <silent> <Leader>tl :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <Leader>rt :let _s=@/<Bar>:%s/\t/    /g<CR>:let @/=_s<Bar>:nohl<CR>

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


" Setup color scheme
set background=dark
try
  colors vividchalk
catch /^Vim\%((\a\+)\)\=:E185/
  colors darkblue   " Fallback to darkblue
endtry

" vim: set ts=2 sw=2 tw=78 et :
