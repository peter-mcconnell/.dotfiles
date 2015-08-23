set nocompatible              " be iMproved, required
filetype off                  " required

set colorcolumn=80

set backspace=2
set laststatus=2

" enabling mouse
set mouse=a

" show line numbers
set nu
set rnu

" show whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'plasticboy/vim-markdown'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'avakhov/vim-yaml'
Plugin 'ingydotnet/yaml-vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'L9'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'markcornick/vim-vagrant'
Plugin 'mattn/emmet-vim'
Bundle 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set t_Co=256

" NERDTree
" autoclose
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | e

" MAPPINGS
map <C-n> :NERDTreeToggle<CR>

" APPEARANCE
syntax enable
set background=dark
try
	colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
	" colorscheme isnt installed
endtry
let g:rehash256 = 1
