" Generic config ***************************************************************

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
set smarttab
set tabstop=2 " Number of space og a <Tab> character
set softtabstop=2
set shiftwidth=2 " Number of spaces use by autoindent
set expandtab " Pressing <Tab> puts spaces, and < or > for indenting

" Display tabs and trailing spaces visually
set list listchars=tab:\»\ ,trail:·
set showbreak=←

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
autocmd FileType java setlocal omnifunc=javacomplete#Complete

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

" Must have Plugs!
if !has('nvim')
  Plug 'Shougo/neocomplete'
else
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'bling/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic', { 'for': ['php', 'java', 'javascript', 'xml', 'css', 'less', 'scss'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'neomake/neomake'

" Git
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'tpope/vim-fugitive'

" Languages
Plug 'dag/vim-fish'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
if has('nvim')
  Plug 'euclio/vim-markdown-composer', { 'for': 'markdown' }
endif
"Plug '74hc595/dcpu16-vim-syntax'
Plug 'alvan/vim-closetag' ", { 'for': ['xml', 'html', 'xhtml']}
let g:closetag_filenames = "*.html,*.xhtml,*.xml"

" D Lang
if !has('nvim')
else
  Plug 'landaire/deoplete-d', { 'for': 'd' }
endif

" Web stuff
Plug 'gko/vim-coloresque', { 'for': ['less', 'scss', 'css', 'html']}
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less', { 'for': ['less']}
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }

" Java
Plug 'mikelue/vim-maven-plugin'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'andreshazard/vim-freemarker'

" Color theme
Plug 'reewr/vim-monokai-phoenix'

filetype plugin indent on                   " required!
call plug#end()

" Vundle ***********************************************************************

" Config Airline and status line
let g:smartusline_string_to_highlight = '(%n) %f '
set laststatus=2 " Seperate lines for state and mode
let g:airline_powerline_fonts=1 " Powerline simbols. Hermit font support it
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#syntastic#enabled=1

" JavaScript & JDoc
let g:javascript_plugin_jsdoc = 1

" Enable indent guides on boot and allow colorschemes to style them.
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#202020' ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#101010'

" Syntastic
set ofu=syntaxcomplete#Complete
let g:syntastic_mode_map={ 'mode': 'active',
\ 'active_filetypes': ['asm', 'dasm', 'inc'],
\ 'passive_filetypes': ['html', 'cpp', 'd'] }
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers=['eslint']

" Autocomplete
if !has('nvim')
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
else
  " Deoplete async autocomplete
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#omni_patterns = {}
  let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
  let g:deoplete#sources = {}
  let g:deoplete#sources._ = []
  let g:deoplete#file#enable_buffer_path = 1
  inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
endif



" Functions and remaps

" Ctrl-S to save file
nmap <C-s> :w<CR>
vmap <C-s> <Esc><c-s>gv
imap <C-s> <Esc><c-s>

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
  colors monokai-phoenix
catch /^Vim\%((\a\+)\)\=:E185/
  colors darkblue   " Fallback to darkblue
endtry

" vim: set ts=2 sw=2 tw=78 et :
