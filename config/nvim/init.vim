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

" Config permanet undo files and backup storage
if has('persistent_undo')
  let undo_path=s:editor_root . '/undodir'
  " Ensure all needed directories exist
  if empty(glob(undo_path . '/'))
    call mkdir(undo_path, "p")
  endif
  let &undodir = undo_path
  set undofile
  set undolevels=1000
  set undoreload=10000

  set backupdir=./.backup,.,$TEMP,$TMP
  set directory=.,./.swp,$TEMP,$TMP
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
Plug 'nathanaelkane/vim-indent-guides' "Show identation levels with different background colors
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'https://gitlab.com/hauleth/qfx.vim.git' " Display signs in lines that have QuicFix entry
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " Vim plugin that shows keybindings in popup
"autocmd! User vim-which-key call which#register(',', 'g:which_key_map')
Plug 'wellle/targets.vim' " Additional text objects -> vat yi
Plug 'rstacruz/vim-closer' " Autoclose pairs brakcets when press enter
let g:closer_flags='{;'
Plug 'jiangmiao/auto-pairs' " Autoclose pairs
let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
Plug 'tpope/vim-surround' " add/change/delete surroding pairs -> dst
"Allow to see registers with '"' or '@' in normal mode or <Ctrl-R> in insert
"mode
Plug 'junegunn/vim-peekaboo'

" Langauge autocomplete and Async completions {{
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'w0rp/ale' " Async linting/fixing
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" }}

" Git
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle'  }
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'tpope/vim-fugitive', { 'on': [ 'Gcommit', 'Gstatus', 'Gblame', 'Gdiff' ] }
Plug 'airblade/vim-gitgutter'
let g:gitgutter_max_signs=1024

" Languages
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 2
set conceallevel=2
"Plug 'tpope/vim-markdown', { 'for': 'markdown' }
if has('nvim')
  function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      !cargo build --release
    endif
  endfunction
  Plug 'euclio/vim-markdown-composer', {'do': function('BuildComposer') }
  let g:markdown_composer_browser = "firefox"
endif
Plug 'alvan/vim-closetag' "Autoclose html/xml tags
let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.vm,*.ftl,*.vue"

" D Lang
if has('nvim')
  Plug 'landaire/deoplete-d', { 'for': 'd' }
endif

" Web stuff
Plug 'chrisbra/Colorizer', { 'for': ['less', 'scss', 'css', 'html', 'vue']}
let g:colorizer_auto_filetype='css,less,scss,html,vue'

Plug 'othree/html5.vim', { 'for': ['html', 'xhtml', 'vm', 'ftl', 'vue'] }
Plug 'actionshrimp/vim-xpath', { 'for': ['xml', 'html', 'xhtml'] }

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

"Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
Plug 'posva/vim-vue', {'for': 'vue'}

" Java
Plug 'artur-shaik/vim-javacomplete2'
Plug 'lepture/vim-velocity'
Plug 'andreshazard/vim-freemarker'

" Color theme
Plug 'haishanh/night-owl.vim'
Plug 'reewr/vim-monokai-phoenix'

filetype plugin indent on                   " required!
call plug#end()

" Vundle ***********************************************************************

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
let g:airline#extensions#ale#enabled = 1
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

" Ale - Asynchronus Linting Engine
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'E' "'❌'
let g:ale_sign_warning = '!'
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

" Autocomplete
if has('nvim')
  " Begin LSP configuration
  let g:LanguageClient_serverCommands = {
    \ 'vhdl': ['vhdl-tool', 'lsp']
      \ }

  let g:LanguageClient_autoStart = 1

  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

  au! CursorHold *.vhd  execute ":call LanguageClient_textDocument_hover()"
  au! CursorHold *.vhdl execute ":call LanguageClient_textDocument_hover()"
  " End LSP configuration

  " Deoplete async autocomplete
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#file#enable_buffer_path = 1
  " Close the preview windows when completion is done
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  " Autocokpelte on TAB
  inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
  " Use <tab> and <S-tab> to navigate the completion list
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

endif


" Functions and remaps
command! WQ wq
command! Wq wq
command! W w
command! Q q

" black hole
map <leader>b "_

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


" Setup color scheme
syntax enable
set background=dark
try
  "colorscheme night-owl
  colorscheme monokai-phoenix
catch /^Vim\%((\a\+)\)\=:E185/
  colors darkblue   " Fallback to darkblue
endtry

" This must be AFTER setting color scheme
" Override colorcolumn color and add overlength when the line is over 120 characters
highlight ColorColumn ctermbg=red ctermfg=white guibg=#351818
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" vim: set ts=2 sw=2 tw=78 et :
