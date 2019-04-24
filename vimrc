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
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Plugins
let vundle_installed=1
set rtp+=~/.config/nvim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'fatih/vim-go'
Plugin 'plasticboy/vim-markdown'
Plugin 'tomasr/molokai'
Plugin 'docker/docker'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'pearofducks/ansible-vim'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-packer'
Plugin 'hashivim/vim-vagrant'
Plugin 'hashivim/vim-vaultproject'
Plugin 'hashivim/vim-nomadproject'
Plugin 'kien/ctrlp.vim'
Plugin 'mhinz/vim-grepper'
Plugin 'konfekt/fastfold'
Plugin 'airblade/vim-gitgutter'
Plugin 'bats.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'w0rp/ale'
Plugin 'ambv/black'
Plugin 'davidhalter/jedi-vim'

call vundle#end()            " required
filetype plugin indent on

" terraform settings
let g:terraform_align=1

" python settings
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3'
let g:python2_host_prog = '/usr/local/bin/python2'
let g:black_linelength = 80

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
" pane remaps
nnoremap pj  <C-W><C-J>
nnoremap pk  <C-W><C-K>
nnoremap pl  <C-W><C-L>
nnoremap ph  <C-W><C-H>
" go to file
nnoremap gf :vertical wincmd f<CR>

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
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType c set omnifunc=ccomplete#Complete

" vim-go
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" vim-terraform
let g:terraform_fmt_on_save = 1

" vim-grepper
nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>G :Grepper -tool ag<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Optional. The default behaviour should work for most users.
let g:grepper               = {}
let g:grepper.tools         = ['git', 'ag', 'rg']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" ale
let g:ale_enabled = 1
let g:ale_completion_enabled = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5
let g:ale_open_list = 1
let g:ale_set_highlights = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_linters = {
        \   'javascript': ['eslint_d'],
        \   'php': ['php', 'phpcs', 'phpmd'],
        \   'go': ['go build', 'gometalinter'],
        \   'rust': ['rustc'],
        \   'html': ['tidy', 'htmlhint'],
        \   'c': ['clang'],
        \   'cpp': ['clang++'],
        \   'css': ['csslint', 'stylelint'],
        \   'nim': ['nim', 'nimsuggest'],
        \   'vim': ['vint'],
        \   'python': ['python', 'black'],
        \   'shell': ['sh', 'shellcheck'],
        \   'zsh': ['zsh'],
        \   'swift': ['swiftc'],
        \   'sql': ['sqlint'],
        \}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'i'
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
let g:ale_echo_cursor = 1
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" jedi-vim
let g:jedi#force_py_version=3

" support for Jenkinsfiles
au BufNewFile,BufRead Jenkinsfile setf groovy

" panes
set splitbelow
set splitright
