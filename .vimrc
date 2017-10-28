" Vim / GVim / MacVim custom configuration file
" Created by Sascha Peilicke <sascha@peilicke.de>
"
" This file is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                            " be iMproved, required
filetype off                                " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'                  " let Vundle manage Vundle, required

Plugin 'editorconfig/editorconfig-vim'
Plugin 'ekalinin/Dockerfile.vim'            " github.com/ekalinin/Dockerfile.vim
Plugin 'fatih/vim-go'
Plugin 'groenewege/vim-less'
Plugin 'keith/swift.vim'
Plugin 'r0mai/vim-djinni'
Plugin 'vim-scripts/nginx.vim'              " github.com/vim-scripts/nginx.vim
Plugin 'vim-syntastic/syntastic'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()                           " required
filetype plugin indent on                   " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noexrc                                  " Potential security risk
set history=1000
set undolevels=1000
set visualbell                              " don't beep
set noerrorbells                            " don't beep
set nobackup                
set noswapfile

"let mapleader=","                           " change the mapleader from \ to ,
let maplocalleader="\\"

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme / colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &t_Co >= 256 || has("gui_running")
    if (system('uname') =~ "Darwin")
    	colorscheme desert
    else
        colorscheme peachpuff
    endif
endif
if &t_Co > 2 || has("gui_running")          " If we have colors
  syntax on                                 " Syntax highlighting
endif

if has("gui_running")                       " GVim or running under GUI
  "hi Normal guibg=black guifg=grey
  "hi String guifg=#FF3333
  "hi Statement guifg=#cf6802
  "hi Folded guibg=black guifg=grey40
  "hi FoldColumn guibg=black guifg=grey40
  "set guifont=FreeMono\ Bold\ 10            " Font for GVim
  winpos 0 50                               " Window position
  set lines=45
else                                        " Vim running in a terminal
  "colorscheme slate
  "hi Folded ctermfg=grey ctermbg=darkgrey
  "hi FoldColumn ctermfg=grey ctermbg=darkgrey
  "hi Comment ctermfg=darkcyan ctermbg=darkgrey
endif

set hidden                                  "  Hide buffers instead of closing them.
set pastetoggle=<F2>
nmap <silent> <leader>/ :nohlsearch<CR>

" D'oh! Forgot sudo again, fix it with:
cmap w!! w !sudo tee % >/dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set number                                 " Line numbers
set mouse=a                                 " Use mouse everywhere
"set backspace=2                             " Backspace over line break
set backspace=indent,eol,start              " Allow backspacing over everything in insert mode
set ruler                                   " Curser pos down tight
"set rulerformat=                           " Ruler format
"set statusline=%F%m%r%h%w\ [Format=%{&ff}]\ [Type=%Y]\ [Ascii=\%03.3b]\ [Hex=\%02.2B]\ [Pos=%04l,%04v][%p%%]\ [Len=%L]
"set laststatus=2  " always show the status line
set splitbelow                              " Split creates new window under old one
set splitright                              " Vsplit creates new window right of old one
set wildmenu                                " Menu when pressing <Tab> for ex commands
set wildignore=*.swp,*.bak,*.pyc,*.class
"set list                                    " Show special (non-printable) characters
"set listchars=tab:\ \ ,eol:$
set scrolloff=3                             " Add some breathing room at top and bottom of screen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text formatting / layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4                               " Tab = 4 space
set softtabstop=4                           " Backspacing a tab removes 4 spaces
set shiftwidth=4                            " number of spaces to use for autoindenting
set shiftround                              " use multiple of shiftwidth when indenting with '<' and '>'
set expandtab                               " Proud member of the 'tabs are evil' crew
set smarttab                                " insert tabs on the start of a line according to shiftwidth, not tabstop
set autoindent                              " Uses the indent from the previous line
set copyindent                              " copy the previous indentation on autoindenting
set smartindent                             " More clever / overrides autoindent where appropriate
set foldmethod=syntax                       " Text is folded based on syntax
set foldlevel=1                             " Open the X level folds
set foldcolumn=1                            " Left column for fold control

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other / custom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autowrite                               " Writes on make / shell commands
set autoread
set clipboard+=unnamed                      " Yanks go on clipboard instead
set showmode                                " Display current mode ('insert', 'replace', ...)
set showcmd                                 " Display partially-typed commands in the status line
set showmatch                               " Show matching braces
set showfulltag
set hlsearch                                " Highlights previous seach pattern
set incsearch                               " Display search patterns while typing
set magic                                   " Use extended regular expressions
set cmdheight=1                             " Vi command line height
set modeline                                " Enable modeline search
set modelines=5                             " Amount of lines (top, bottom) to search
set title                                   " change the terminal's title
set ofu=syntaxcomplete#Complete             " Turn on omnicompletion

if exists("+omnifunc")
autocmd Filetype *
\ if &omnifunc == "" |
\   setlocal omnifunc=syntaxcomplete#Complete |
\ endif
endif

autocmd BufRead,BufNewFile *.json setf js
autocmd BufRead,BufNewFile *.m setf objc

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
"autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

" Some convenient keymappings
map tt <ESC>:%s/\t/    /g<CR>               " Convert tab to 4 spaces
map tT <ESC>:%s/    /\t/g<CR>               " Convert 4 spaces to tab

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Don't jump over long wrapped lines but always jump to the next editor row
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GNU screen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"maptimeout 5                                " If Esc key doesn't work:
" Fix keycodes
map ^[[1~ <Home>
map ^[[4~ <End>
imap ^[[1~ <Home>
imap ^[[4~ <End>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python / Django options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BicycleRepairMan - refactoring for Python settings
let g:bike_exceptions = 1                   " Show tracebacks on exceptions
let g:bike_progress = 1                     " Show import progress
let g:pydoc_highlight= 1                    " Highlighting for pydoc

autocmd FileType python set foldmethod=indent shiftwidth=4 softtabstop=4 omnifunc=pythoncomplete#Complete
autocmd BufRead,BufNewFile zcml,pt setf xml   " Zope
" Many people like to remove any extra whitespace from the ends of lines.
" Here is one way to do it when saving your file.
"autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd FileType htmldjango set foldmethod=indent shiftwidth=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C / C++ options and related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow vim find to find a Qt source file anytime w/o knowing the directory" layout
set path=,$QTSRCDIR/src/**,$QTDIR/src/**
set tags=./tags,tags,$QTSRCDIR/src/tags,$QTDIR/src/tags
let c_space_errors=1                        " Show unneeded spaces as errors in C code

autocmd FileType c,cpp set cindent omnifunc=ccomplete#Complete
" Makefile options
autocmd FileType Makefile set noexpandtab shiftwidth=8 softtabstop=8 "tabstop=8
" CMake options
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in,*.ctest,*.ctest.in setf cmake
" Qt options
autocmd BufRead,BufNewFile *.qrc, *.rc setf xml

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby / Ruby on Rails options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType rb,ruby,eruby set foldmethod=indent shiftwidth=2 softtabstop=2 omnifunc=rubycomplete#Complete
autocmd FIleType cucumber set foldmethod=indent shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile Fastfile setf ruby

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" XML / HTML / CSS / JavaScript options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:xml_syntax_folding = 1                " syntax folding

autocmd FileType html set foldmethod=syntax shiftwidth=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml set foldmethod=indent shiftwidth=2 softtabstop=2 omnifunc=xmlcomplete#CompleteTags
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""V"""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_fold_enabled = 1                  " syntax-based folding for (La)Tex

" Android
autocmd BufReadCmd *.aar call zip#Browse(expand("<amatch>"))

" Systemd options
autocmd BufRead,BufNewFile *.service setf desktop

" Open Build Service options
autocmd BufRead,BufNewFile _service setf xml

" SQL options
autocmd FileType sql set omnifunc=sqlcomplete#Complete

" Quick fix window
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd BufRead,BufNewFile *.conf setf config
" nginx.vim - https://github.com/vim-scripts/nginx.vim see bundle
autocmd BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/*,nginx.conf setf nginx

autocmd FIleType yaml set foldmethod=indent shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.spdx setf yaml " SPDX

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""V"""""""""""""""""""""""""""""""""""""""""""""""
" NetRW
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_python_checkers = ['flake8']
