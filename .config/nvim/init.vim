set ignorecase

set incsearch
set hlsearch

set showcmd
set showmode

set number relativenumber
set tabstop=2
set scrolloff=8
set sidescrolloff=12
set sidescroll=1

set clipboard+=unnamedplus

set ttyfast

set wrap
set showbreak=↪ 

set background=dark

" ======= remaps 
map L $
map H ^

map Y yy
map Y yy

" Create splitpanes
"" split horizontal
nnoremap <A-0> <C-W>s
"" split vertical
nnoremap <A--> <C-W>v
"" close pane
nnoremap <A-=> <C-W>q

" move split panes
nnoremap <A-h> <C-W>H
nnoremap <A-j> <C-W>J
nnoremap <A-k> <C-W>K
nnoremap <A-l> <C-W>L

" move between panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
