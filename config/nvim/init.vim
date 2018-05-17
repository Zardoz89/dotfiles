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
set list listchars=tab:‣\ ,nbsp:␣,extends:▶,trail:·
let &showbreak = '↳ '"'←'

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
set laststatus=2 " Seperate lines for state and mode
set showmode " Show current mode in the status line.
set showcmd " Show the command in the status line.

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
autocmd FileType make set noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType md set expandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType xml setl noexpandtab nosta sw=4 sts=4 tabstop=4
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType css,sass,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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

" Config permanet undo files
if has('persistent_undo')
  let undo_path=s:editor_root . '/undodir'
  if empty(glob(undo_path . '/'))
    " Ensure all needed directories exist
    call mkdir(undo_path, "p")
  endif
  let &undodir = undo_path
  set undofile
  set undolevels=1000
  set undoreload=10000
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
Plug 'bling/vim-airline'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'
Plug 'w0rp/ale'
if !has('nvim')
  Plug 'Shougo/neocomplete'
else
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
if has('nvim')
  Plug 'kassio/neoterm'
  set shell=/usr/bin/fish
  let g:neoterm_shell = "fish"
endif

" Git
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Languages
Plug 'dag/vim-fish'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
if has('nvim')
  function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      !cargo build --release
    endif
  endfunction
  Plug 'euclio/vim-markdown-composer', {'do': function('BuildComposer') }
endif
Plug 'alvan/vim-closetag'
let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.vm,*.ftl,*.vue"
Plug 'jiangmiao/auto-pairs'

" D Lang
if has('nvim')
  Plug 'landaire/deoplete-d', { 'for': 'd' }
endif

" Web stuff
Plug 'chrisbra/Colorizer', { 'for': ['less', 'scss', 'css', 'html', 'vue']}
let g:colorizer_auto_filetype='css,less,scss,html,vue'

Plug 'othree/html5.vim', { 'for': ['html', 'xhtml', 'vm', 'ftl', 'vue'] }

Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less', { 'for': ['less']}
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'othree/csscomplete.vim', { 'for': ['less', 'scss', 'css', 'vue'] }

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'vue']}
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'vue'] }
if has('nvim')
  Plug 'carlitux/deoplete-ternjs'
  Plug 'ponko2/deoplete-fish'
endif

Plug 'posva/vim-vue', {'for': 'vue'}

" Java
Plug 'mikelue/vim-maven-plugin'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'lepture/vim-velocity'
Plug 'andreshazard/vim-freemarker'

" Eclim -> Control Eclipse from VIm
"Plug '~/.config/nvim/bundle/eclim'

" Color theme
Plug 'reewr/vim-monokai-phoenix'

filetype plugin indent on                   " required!
call plug#end()

" Vundle ***********************************************************************

" NERD tree
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=1
let NERDTreeNaturalSort=1
let NERDTreeChDirMode=1

" Config Airline and status line
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
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#202020' ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#101010'

" Ale async syntax
let g:airline#extensions#ale#enabled = 1

" Autocomplete
if has('nvim')
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

" Window navigation
nnoremap <Leader><Up>     <C-W><Up>
nnoremap <Leader><Down>   <C-W><Down>
nnoremap <Leader><Left>   <C-W><Left>
nnoremap <Leader><Right>  <C-W><Right>

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

" Keep selected block when change indentation level
vnoremap < <gv
vnoremap > >gv


" Setup color scheme
set background=dark
try
  colors monokai-phoenix
catch /^Vim\%((\a\+)\)\=:E185/
  colors darkblue   " Fallback to darkblue
endtry

" This must be AFTER setting color scheme
" Override colorcolumn color and add overlength when the line is over 120 characters
highlight ColorColumn ctermbg=red ctermfg=white guibg=#351818
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" vim: set ts=2 sw=2 tw=78 et :
