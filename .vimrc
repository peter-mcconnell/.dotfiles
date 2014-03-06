" load in pathogen <https://github.com/tpope/vim-pathogen>
execute pathogen#infect()

" disable line numbers handier for copy/paste
set nonu

" enable syntax highlighting
syntax on

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

" allow backspacing over autoindent
set backspace=indent,eol,start

" indents
set autoindent
set shiftwidth=4
set softtabstop=4
set expandtab

" ruler
set ruler

" always display status line
set laststatus=2

" instead of failing a command because of unsaved changes prompt save
set confirm

" use visual bell instead of audio bleep
set visualbell

