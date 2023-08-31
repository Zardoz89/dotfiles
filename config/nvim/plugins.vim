
" Must have Plugs!
Plug 'bling/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'https://gitlab.com/hauleth/qfx.vim.git' " Display signs in lines that have QuickFix entry
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " Vim plugin that shows keybindings in popup
"autocmd! User vim-which-key call which#register(',', 'g:which_key_map')
Plug 'wellle/targets.vim' " Additional text objects -> vat yi
"Plug 'rstacruz/vim-closer' " Autoclose pairs brackets when press enter
"let g:closer_flags='{;'
"Plug 'jiangmiao/auto-pairs' " Autoclose pairs
"let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
Plug 'tpope/vim-surround' " add/change/delete surroding pairs -> dst
"Allow to see registers with '"' or '@' in normal mode or <Ctrl-R> in insert mode
Plug 'junegunn/vim-peekaboo'

if has('nvim')
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'lukas-reineke/indent-blankline.nvim'
else
  Plug 'nathanaelkane/vim-indent-guides' "Show identation levels with different background colors
endif

" Git
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle'  }
Plug 'airblade/vim-gitgutter'
let g:gitgutter_max_signs=1024

" Languages
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 2
set conceallevel=2
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown'}
Plug 'alvan/vim-closetag' "Autoclose html/xml tags
let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.vm,*.ftl,*.vue"

" Web stuff
Plug 'norcalli/nvim-colorizer.lua', { 'for': ['less', 'scss', 'css', 'html', 'vue', 'js']}

Plug 'othree/html5.vim', { 'for': ['html', 'xhtml', 'vm', 'ftl', 'vue'] }
Plug 'actionshrimp/vim-xpath', { 'for': ['xml', 'html', 'xhtml'] }

Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less', { 'for': ['less']}
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'othree/csscomplete.vim', { 'for': ['less', 'scss', 'css', 'vue'] }

Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'vue']}
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'vue'] }
Plug 'posva/vim-vue', {'for': 'vue'}

" Java
Plug 'artur-shaik/vim-javacomplete2'
Plug 'lepture/vim-velocity'
Plug 'andreshazard/vim-freemarker'

" DIV Games Studio
Plug 'Zardoz89/vim-div'

" Color theme
Plug 'haishanh/night-owl.vim'
Plug 'tomasr/molokai'

" Vim using nice font icons!
Plug 'ryanoasis/vim-devicons'

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-lists', 'coc-json', 'coc-highlight', 'coc-css', 'coc-eslint', 'coc-tsserver', 'coc-git', 'coc-yaml',
  \ 'coc-vimlsp', 'coc-xml', 'coc-fish', 'coc-sh'
  \]

filetype plugin indent on                   " required!
call plug#end()

" vim: set ts=2 sw=2 tw=78 et :
