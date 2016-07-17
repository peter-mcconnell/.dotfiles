filetype plugin indent on

set autochdir " make working directory same as open file
set nocompatible              " be iMproved, required
set colorcolumn=80
set backspace=2
set laststatus=2
set mouse=a " enabling mouse
set nu
set rnu
set list listchars=tab:\ \ ,trail:·
set list
set rtp+=~/.vim/bundle/Vundle.vim
set t_Co=256
set history=1000
set showmode
set gcr=a:blinkon0
set visualbell
set autoread
set hidden
set noswapfile
set nobackup
set nowb
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set linebreak
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set incsearch
set hlsearch
set ignorecase
set smartcase

" Plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'plasticboy/vim-markdown'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'avakhov/vim-yaml'
Plugin 'StanAngeloff/php.vim'
Plugin 'L9'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'mitchellh/vagrant'
Plugin 'docker/docker'
Bundle 'tomasr/molokai'

call vundle#end()            " required

" golang settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

let g:rehash256 = 1

" tab remaps
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" NERDTree
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | e

" MAPPINGS
map <C-n> :NERDTreeToggle<CR>

" APPEARANCE
syntax on
set background=dark
try
	colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
	" colorscheme isnt installed
endtry
