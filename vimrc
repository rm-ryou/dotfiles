"[ ###----- Basic Settings -----### ] {{{

map , <Plug>(customPrefix)
let mapleader = ' '
inoremap <silent> jj <ESC>

syntax on

set number
set cursorline


"### Search {{{
set ignorecase
set smartcase
set hlsearch
set incsearch

nnoremap <silent> <leader>nh :nohlsearch<CR>
"}}}
"### Indent {{{
set autoindent
set smartindent
set smarttab
set cindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
"}}}
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
"[ ###----- Plugins Settings -----### ] {{{
"### fzf {{{
" Initialize configuration dictionary
let g:fzf_vim = {}

let $FZF_DEFAULT_OPTS = getenv('FZF_DEFAULT_OPTS') . ' --bind=ctrl-f:preview-down,ctrl-d:preview-up'
nnoremap <silent> <Plug>(customPrefix)f :Files<CR>
nnoremap <silent> <Plug>(customPrefix)b :Buffers<CR>
"}}}
"### indentLine {{{
let g:indentLine_char = '|'
let g:vim_json_conceal = 0
let g:markdown_syntax_conceal = 0
"}}}
"### lsp {{{
if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gh <plug>(lsp-hover)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
  nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
"}}}
"### nerdtree {{{
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
"}}}
"### vim-airline {{{
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#default#layout = [
      \ [ 'a', 'c' ],
      \ [ 'x', 'y' ],
      \ ]
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = []
"}}}
"### yanktmp {{{
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
"}}}
"}}}
