"[ ###----- Basic Settings -----### ] {{{

inoremap <silent> jj <ESC>

set number
set cursorline

"### Folding {{{
set foldmethod=marker
set foldtext=FoldCCtext()
"}}}

"}}}
"[ ###----- Plugins -----### ] {{{
call plug#begin()
"# Basic
Plug 'houtsnip/vim-emacscommandline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-niceblock'
Plug 'magicdrive/foldCC'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdtree'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-commentary'
Plug 'troydm/easybuffer.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/yanktmp.vim'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'vim-scripts/surround.vim'
Plug 'Yggdroot/indentLine'

"# Go
Plug 'mattn/vim-goimports'

"# LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()
"}}}
