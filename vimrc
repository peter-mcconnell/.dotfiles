filetype off " required for vundle

set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
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
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'
Plugin 'plasticboy/vim-markdown'
Plugin 'docker/docker'
Bundle 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'justinmk/vim-sneak'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'dkprice/vim-easygrep'
Plugin 'suan/vim-instant-markdown'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'millermedeiros/vim-esformatter'
Plugin 'digitaltoad/vim-pug'
Plugin 'node.js'
Plugin 'SuperTab'

call vundle#end()            " required

" golang settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

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

" other
let g:sneak#streak = 1
let g:airline_theme='bubblegum'
