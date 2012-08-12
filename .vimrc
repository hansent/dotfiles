let mapleader = ","
call pathogen#infect()


"key mappings
"====================================================================

"edit .vimrc
map ,v :sp ~/.vimrc<cr>

"F!%*ing WRITE IT
cmap W! w !sudo tee % >/dev/null

"map ctrl c/v to use system clipboard
map <C-S-v> "+P
map <C-S-c> "+Y


"fix indent for whole file
map <leader>gg gg=G

" remove trailing whitespace
map <leader>w :call StripTrailingWhiteSpace()<CR>

"flake8 / pep8 check
map <Leader>f :call Flake8()<CR>

"command-t  plugin
map <Leader>e :CommandT<CR>
map <Leader>b :CommandTBuffer<CR>
map <Leader>t :CommandT<CR>
map <D-t> :CommandT<CR>

"keep selection for indnet in visual mode
vnoremap > >gv
vnoremap < <gv

"match bracktes
nmap <tab> %
vmap <tab> %

map <C-,> <C-w><left>
map <C-.> <C-w><right>


"editor settings
"====================================================================
set enc=utf-8

"tabing
set smarttab
set tabstop=8
set expandtab

"search
set hlsearch
set incsearch

"allow hidden buffer and backup files somewhere else
set hidden
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions



"interface settings
"====================================================================
:colorscheme zenburn
highlight ColorColumn guibg=#554444
set number
set colorcolumn=80,81
set cursorline
set completeopt-=preview

"status & command line
set cmdheight=1
set laststatus=2
set showcmd
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" turn off any kind of bell
set gcr=a:blinkon0
set noerrorbells
set vb

set ttyfast
set scrolloff=10

set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*$py.class,*.class
set wildmode=list:full
set completeopt=menu,menuone,longest
set pumheight=15

set title
set titleold="Terminal"
set titlestring=%F

set guioptions-=T     "dont show gui toolbar
set guioptions-=r     "remove right- and left-hand scrollbars
set guioptions-=L
set guioptions-=m     "dont show menu



"plugin options
"=============================================================================
let g:SuperTabDefaultCompletionType="context"
let g:CommandTMaxHeight=10



"filetype behaviour / auto commands
"=============================================================================
filetype plugin indent on

" python support
" --------------
let python_highlight_all=1
let python_highlight_exceptions=0

au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent
"au FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(
au FileType python set omnifunc=pythoncomplete#Complete
au BufWritePre *.py call StripTrailingWhiteSpace()
au BufWritePost *.py call Flake8()


au FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au FileType pyrex set omnifunc=pythoncomplete#Complete
"au FileType pyrex set complete+=k~/.vim/syntax/python.vim isk+=.,(


au FileType kivy setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent
au BufNewFile,BufRead *.kv set filetype=kivy
au BufWritePre *.kv call StripTrailingWhiteSpace()


" Other filetype settings, mostly stolen from Armin Ronacher's .vimrc
" https://github.com/mitsuhiko/dotfiles/blob/master/vim/vimrc

" template language support (SGML / XML too)
" ------------------------------------------
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let html_no_rendering=1


" ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" go support
" ----------
autocmd BufNewFile,BufRead *.go setlocal ft=go
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" php support
" -----------
autocmd FileType php setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab

" GLSL
" ----
autocmd bufnewfile,bufread *.frag,*.fragment,*.vert,*.vertex,*.shader,*.glsl,*.vs,*.fs, setlocal ft=glsl
autocmd FileType glsl setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Verilog
" -------
autocmd FileType verilog setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" CSS
" ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab

" rst
" ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
\ formatoptions+=nqt textwidth=74

" C#
autocmd FileType cs setlocal tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" C/Obj-C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
let c_no_curly_error=1

" Octave/Matlab
autocmd FileType matlab setlocal tabstop=8 softtabstop=2 shiftwidth=2 expandtab

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" Javascript
" ----------
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
let javascript_enable_domhtmlcss=1

" CoffeeScript
" ------------
autocmd FileType coffee setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" D
" -
autocmd FileType d setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" cmake support
" -------------
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

"source .vimrc on write
au! BufWritePost .vimrc source ~/.vimrc

fun! StripTrailingWhiteSpace()                                              
  let l = line(".")                                                         
  let c = col(".")                                                          
  %s/\s\+$//e                                                               
  call cursor(l, c)                                                         
endfun 
