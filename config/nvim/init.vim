set path+=**

set shell=/bin/bash
filetype off " required for vundle

set ma
set foldlevelstart=99
set clipboard=unnamedplus
set updatetime=300

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set splitbelow
set splitright
set cf
set lsp=0
set wildmenu
set wildmode=list:longest
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png
set ruler
set cmdheight=2
set lz
set whichwrap+=<,>,h,l
set autochdir " make working directory same as open file
set nocompatible              " be iMproved, required
set colorcolumn=80
set backspace=2
set laststatus=2
set mouse=a " enabling mouse
set showmatch
set mat=5
set nu
set list listchars=tab:\ \ ,trail:·
set list
set t_Co=256
set history=1000
set showmode
set gcr=a:blinkon0
set visualbell
set autoread
set hidden
set noswapfile
set nobackup
set nowritebackup
set nowb
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=4
set tabstop=4
set expandtab
set switchbuf+=usetab,newtab
set linebreak
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set incsearch
set nohlsearch
set ignorecase
set smartcase
set showcmd
set cursorline
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Plugins
let vundle_installed=1
set rtp+=~/.config/nvim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'docker/docker'
Plugin 'tpope/vim-git'
Plugin 'vim-airline/vim-airline'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-packer'
Plugin 'hashivim/vim-vagrant'
Plugin 'dense-analysis/ale'
Plugin 'averms/black-nvim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'aliou/bats.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'neoclide/coc.nvim'
Plugin 'nvim-lua/popup.nvim'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-treesitter/nvim-treesitter'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'nvim-telescope/telescope-fzy-native.nvim'
Plugin 'fannheyward/telescope-coc.nvim'
Plugin 'tpope/vim-fugitive'
Plugin 'arzg/vim-colors-xcode'

call vundle#end()            " required
filetype plugin indent on

" there's almost certainly a better way to do this
if !&rtp =~ "telescope.actions"
  " sprinkle in my own sprinkles
  lua require("peter-mcconnell")
endif
