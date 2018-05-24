set shell=/bin/bash
filetype off " required for vundle

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
set cmdheight=1
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
set rnu
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
set hlsearch
set ignorecase
set smartcase
set showcmd
set cursorline
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Plugins
let vundle_installed=1
set rtp+=~/.config/nvim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'fatih/vim-go'
Plugin 'shougo/deoplete.nvim'
Plugin 'zchee/deoplete-go'
Plugin 'plasticboy/vim-markdown'
Plugin 'JamshedVesuna/vim-markdown-preview'
Bundle 'tomasr/molokai'
Plugin 'ekalinin/dockerfile.vim'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'justinmk/vim-sneak'
Plugin 'dkprice/vim-easygrep'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'millermedeiros/vim-esformatter'
Plugin 'digitaltoad/vim-pug'
Plugin 'node.js'
Plugin 'SuperTab'
Plugin 'rodjek/vim-puppet'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-packer'
Plugin 'hashivim/vim-vagrant'
Plugin 'hashivim/vim-consul'
Plugin 'hashivim/vim-vaultproject'
Plugin 'hashivim/vim-nomadproject'
Plugin 'kien/ctrlp.vim'
Plugin 'konfekt/fastfold'
Plugin 'junegunn/vim-github-dashboard'
Plugin 'airblade/vim-gitgutter'
Plugin 'thaerkh/vim-workspace'
Plugin 'bash-support.vim'
Plugin 'klen/python-mode'
Plugin 'groovy.vim'

call vundle#end()            " required
filetype plugin indent on

" terraform settings
let g:terraform_align=1

" python settings
let g:python3_host_prog = '/usr/local/bin/python3'

" golang settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" markdown preview
let vim_markdown_preview_github=1

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
let NERDTreeIgnore=['\.DS_Store$']
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

" autocommands
au BufRead,BufNewFile *.zcml set filetype=xml
au BufRead,BufNewFile *.rb,*.rhtml set tabstop=2
au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2
au BufRead,BufNewFile *.otl set syntax=blockhl
au BufRead,BufNewFile *.json set syntax=javascript
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType c set omnifunc=ccomplete#Complete

" vim-terraform
let g:terraform_fmt_on_save = 1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_eslint_checker = 1
let g:syntastic_javascript_checkers = ['eslint']

" Use deoplete.
set runtimepath+=~/.vim/bundle/deoplete.nvim/
let g:deoplete#enable_at_startup = 1

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" support for Jenkinsfiles
au BufNewFile,BufRead Jenkinsfile setf groovy

" other
let g:sneak#streak = 1
