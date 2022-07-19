" centering
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" fix bps
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ; ;<c-g>u

" fix jumplists
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" moving shit around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc> :m .+1<CR>==
inoremap <C-k> <esc> :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" tab remaps
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" panes
set splitbelow
set splitright

" pane remaps
nnoremap pj  <C-W><C-J>
nnoremap pk  <C-W><C-K>
nnoremap pl  <C-W><C-L>
nnoremap ph  <C-W><C-H>

" go to file
nnoremap gf :vertical wincmd f<CR>

" appearance
syntax enable
set background=dark
colorscheme tokyonight
hi Visual term=reverse cterm=reverse guibg=Grey

" allow project-specific vimrc files
set exrc
set secure

" custom file extensions
autocmd BufRead,BufNewFile *.sh.tpl set filetype=sh
autocmd BufRead,BufNewFile *.py.tpl set filetype=python

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

" quickfix
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
map <C-j> :cn<CR>
map <C-k> :cp<CR>
nnoremap <C-q> :call ToggleQuickFix()<CR>
