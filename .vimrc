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
set history=1000
filetype plugin indent on                   " Enable all VIM's greatness

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme / colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &t_Co > 2 || has("gui_running")          " If we have colors
  syntax on                                 " Syntax highlighting
endif

if has("gui_running")                       " GVim or running under GUI
  colorscheme peachpuff
  "colorscheme default
  "hi Normal guibg=black guifg=grey
  "hi String guifg=#FF3333
  "hi Statement guifg=#cf6802
  "hi Folded guibg=black guifg=grey40
  "hi FoldColumn guibg=black guifg=grey40
  set guifont=FreeMono\ Bold\ 10            " Font for GVim
  winpos 0 50                               " Window position
  set lines=45
else                                        " Vim running in a terminal
  colorscheme peachpuff
  "colorscheme default
  "hi Folded ctermfg=grey ctermbg=darkgrey
  hi Comment ctermfg=blue ctermbg=darkgrey
  "hi FoldColumn ctermfg=grey ctermbg=darkgrey
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set number                                 " Line numbers
set mouse=a                                 " Use mouse everywhere
set backspace=2                             " Backspace over line break
set ruler                                   " Curser pos down tight
"set rulerformat=                           " Ruler format
"set statusline=%F%m%r%h%w\ [Format=%{&ff}]\ [Type=%Y]\ [Ascii=\%03.3b]\ [Hex=\%02.2B]\ [Pos=%04l,%04v][%p%%]\ [Len=%L]
"set laststatus=2  " always show the status line
set splitbelow                              " Split creates new window under old one
set splitright                              " Vsplit creates new window right of old one
set wildmenu                                " Menu when pressing <Tab> for ex commands
"set list                                    " Show special (non-printable) characters
"set listchars=tab:\ \ ,eol:$

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text formatting / layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set tabstop=4                               " Tab = 4 space
set softtabstop=4                           " Backspacing a tab removes 4 spaces
set shiftwidth=4                            " Unify with tabstop
set expandtab                               " Proud member of the 'tabs are evil' crew
set smarttab
set autoindent                              " Uses the indent from the previous line
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
set incsearch                               " Display search patterns while typing
set hlsearch                                " Highlights previous seach pattern
set magic                                   " Use extended regular expressions
set cmdheight=1                             " Vi command line height
set modeline                                " Enable modeline search
set modelines=5                             " Amount of lines (top, bottom) to search
set title
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python / Django options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BicycleRepairMan - refactoring for Python settings
let g:bike_exceptions = 1                   " Show tracebacks on exceptions
let g:bike_progress = 1                     " Show import progress
let g:pydoc_highlight= 1                    " Highlighting for pydoc

if has("autocmd")
  " Python options
  " When editing a *.py file, map <F6> to save and execute python interpreter
  "autocmd BufRead,BufNewFile *.py map <F6> :w<CR>:!python %<CR>
  autocmd FileType python set foldmethod=indent omnifunc=pythoncomplete#Complete
  autocmd BufRead,BufNewFile zcml,pt setf xml

  " The following line sets the smartindent mode for *.py files. It means
  " that after typing lines which start with any of the keywords in the
  " list (ie. def, class, if, etc) the next line will automatically indent
  " itself to the next level of indentation:
  autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

  " Many people like to remove any extra whitespace from the ends of lines.
  " Here is one way to do it when saving your file.
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

  " Django options
  autocmd FileType htmldjango set foldmethod=syntax shiftwidth=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags
  "au BufNewFile,BufRead admin.py     setlocal filetype=python.django
  "au BufNewFile,BufRead urls.py      setlocal filetype=python.django
  "au BufNewFile,BufRead models.py    setlocal filetype=python.django
  "au BufNewFile,BufRead views.py     setlocal filetype=python.django
  "au BufNewFile,BufRead settings.py  setlocal filetype=python.django
  "au BufNewFile,BufRead forms.py     setlocal filetype=python.django
  "au BufNewFile,BufRead urls.py      setlocal nowrap
  "au BufNewFile,BufRead settings.py  normal! zR
  "au BufNewFile,BufRead dashboard.py normal! zR

  autocmd BufRead,BufNewFile *.service setf desktop
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C / C++ options and related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow vim find to find a Qt source file anytime w/o knowing the directory" layout
set path=,$QTSRCDIR/src/**,$QTDIR/src/**
set tags=./tags,tags,$QTSRCDIR/src/tags,$QTDIR/src/tags
let c_space_errors=1                        " Show unneeded spaces as errors in C code

if has("autocmd")
  autocmd FileType c,cpp set cindent

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
  autocmd BufRead,BufNewFile *.rb map <F6> :w<CR>:rubyf %<CR>
  autocmd BufRead,BufNewFile *.rb,*.erb set foldmethod=indent shiftwidth=2 softtabstop=2 "tabstop=2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" XML options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:xml_syntax_folding = 1                " syntax folding

if has("autocmd")
  autocmd FileType xml set foldmethod=indent shiftwidth=2 softtabstop=2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HTML / CSS / JavaScript options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd FileType html set foldmethod=syntax shiftwidth=2 softtabstop=2 omnifunc=htmlcomplete#CompleteTags

  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  " Some basic, perfectly serviceable folding:
  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}

  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" (La)TeX options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tex_fold_enabled = 1                  " syntax-based folding for (La)Tex
