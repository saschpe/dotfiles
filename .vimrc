" Vim / GVim custom configuration file
" Created by Sascha Peilicke <saschpe@gmx.de>
"
" This file is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                            " Get rid of Ex-Mode
set noexrc                                  " Potential security risk

" Use pathogen to easily modify the runtime path to include all plugins under
" " the ~/.vim/bundle directory
filetype off                                " force reloading *after* pathogen loaded
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on                   " Enable all VIM's greatness
syntax on

set history=1000
set undolevels=1000

set visualbell                              " don't beep
set noerrorbells                            " don't beep

set nobackup                
set noswapfile

" change the mapleader from \ to ,
let mapleader=","
let maplocalleader="\\"

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme / colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &t_Co >= 256 || has("gui_running")
  colorscheme slate
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
  hi Comment ctermfg=darkcyan ctermbg=darkgrey
endif

"  Hide buffers instead of closing them.
set hidden

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
"set tabstop=4                               " Tab = 4 space
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
set autowrite
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

if has("autocmd") 
  if exists("+omnifunc")
    autocmd Filetype *
    \ if &omnifunc == "" |
    \   setlocal omnifunc=syntaxcomplete#Complete |
    \ endif
  endif

  autocmd BufRead,BufNewFile *.json setf js
  autocmd BufRead,BufNewFile *.m setf objc
  autocmd BufRead,BufNewFile *.go setf go
endif

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

if has("autocmd")
  autocmd FileType python set foldmethod=indent shiftwidth=4 softtabstop=4 omnifunc=pythoncomplete#Complete
  autocmd BufRead,BufNewFile zcml,pt setf xml   " Zope

  " Many people like to remove any extra whitespace from the ends of lines.
  " Here is one way to do it when saving your file.
  "autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

  autocmd FileType htmldjango set foldmethod=indent shiftwidth=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C / C++ options and related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow vim find to find a Qt source file anytime w/o knowing the directory" layout
set path=,$QTSRCDIR/src/**,$QTDIR/src/**
set tags=./tags,tags,$QTSRCDIR/src/tags,$QTDIR/src/tags
let c_space_errors=1                        " Show unneeded spaces as errors in C code

if has("autocmd")
  autocmd FileType c,cpp set cindent omnifunc=ccomplete#Complete

  " Makefile options
  autocmd FileType Makefile set noexpandtab shiftwidth=8 softtabstop=8 "tabstop=8

  " CMake options
  autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
  autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in,*.ctest,*.ctest.in setf cmake

  " Qt options
  autocmd BufRead,BufNewFile *.qrc, *.rc setf xml
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby / Ruby on Rails options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd FileType rb,ruby,eruby set foldmethod=indent shiftwidth=2 softtabstop=2 omnifunc=rubycomplete#Complete
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" XML / HTML / CSS / JavaScript options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:xml_syntax_folding = 1                " syntax folding

if has("autocmd")
  autocmd FileType html set foldmethod=syntax shiftwidth=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml set foldmethod=indent shiftwidth=2 softtabstop=2 omnifunc=xmlcomplete#CompleteTags
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_fold_enabled = 1                  " syntax-based folding for (La)Tex

if has("autocmd")
  " Systemd options
  autocmd BufRead,BufNewFile *.service setf desktop

  " Open Build Service options
  autocmd BufRead,BufNewFile _service setf xml

  " SQL options
  autocmd FileType sql set omnifunc=sqlcomplete#Complete
endif
