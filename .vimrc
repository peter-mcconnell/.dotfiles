" load in pathogen <https://github.com/tpope/vim-pathogen>
execute pathogen#infect()

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" show tabs
set listchars=tab:>.
set list

" enable line numbers 
set nu

" enable syntax highlighting
syntax on
colorscheme murphy 
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
set encoding=utf8
set ffs=unix,dos,mac

" window switching
set hidden

" better command-line completion
set wildmenu

" show partial commands in the last line of the screen
set showcmd

" highlight searches
set hlsearch

" ignore case sensitivity (except on uppercasing)
set ignorecase
set smartcase

" Makes search act like search in modern browsers
set incsearch

" allow backspacing over autoindent
set backspace=indent,eol,start

" Set to auto read when a file is changed from the outside
set autoread

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Enable filetype plugins
filetype plugin on
filetype indent on

" indents
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set wrap

set lbr
set tw=500

" A buffer becomes hidden when it is abandoned
set hid

" Height of the command bar
set cmdheight=2

" ruler
set ruler

" always display status line
set laststatus=2
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

" instead of failing a command because of unsaved changes prompt save
set confirm

" use visual bell instead of audio bleep
set noerrorbells
set novisualbell
set t_vb=
set tm=500

