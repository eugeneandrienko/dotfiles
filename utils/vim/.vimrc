"после установки под Win7, надо не забыть переименовать директорию lang
"в lang_orig, в каталоге установки vim'а!
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YOU SHOULD INSTALL Vundle first!!!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"

set runtimepath+=~/.vim
set nocompatible                        "Не нужна мне совместимость с vi!



" Install plugin manager
" Usage - :Bundle<TAB>
" Launch this to install:
"    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" List of installed plugins:
Plugin 'gmarik/Vundle.vim'
Plugin 'a.vim'
Plugin 'errormarker.vim'
Plugin 'taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Townk/vim-autoclose'
Plugin 'snipMate'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'mhinz/vim-startify'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'

call vundle#end()
filetype plugin indent on


"" CONTENTS:
""" *) General
""" *) Encoding
""" *) Files
""" *) Searching
""" *) Indents
""" *) Look and Feel
""" *) Statusline (airline)
""" *) GUI Settings
""" *) Coding
""" *) TagList
""" *) Python-mode
""" *) Conque-term settings
""" *) vim-better-whitespace
""" *) Keybindings



""
"" General
""
" Save 50 lines in cmdline history
set history=50
" Backspace works through EOL, TABs, etc...
set backspace=indent,eol,start
" Autocomplete by <C-n>
set wcm=<C-n>
" Do not stop cursor at the EOL
set whichwrap=<,>,[,],h,l
" Current directory == directory of file in current buffer
set autochdir
" Do not read config-file from current directory
set noex
" Unknown magic
map Q gq
" Enable syntax highlighting
syntax on
" Reread .vimrc after write
autocmd! bufwritepost $VIM/.vimrc execute "normal! :source $VIM/.vimrc"
" Switch to last known cursor position in opened file.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif



""
"" Encoding
""
" Default encoding for terminal
set termencoding=utf8
"
set fileformats=unix,dos,mac
"
set fileencodings=utf8,cp1251,cp866,koi8-r
" Default codepage
set encoding=utf8
" Codepage for THIS file
scriptencoding=utf8




""
"" Files
""
" Do not create backup files (filename.txt~)
set nobackup
" Write all changes in file if we are switching to another file
set autowrite
"
set directory=~/.vim/swapfiles
"
set undodir=~/.vim/undodir
" Enable infinite undo
set undofile



""
"" Searching
""
" Show first matching word, when typing pattern
set incsearch
" Do not highlight matching words
set nohlsearch
"
set ignorecase




""
"" Indents
""
" Enable smart indents
set autoindent
set smartindent
set cindent
" Copy indent from previous line for current line
set ai
" C-style indentation
set cin
" Size of tab (in spaces)
set tabstop=4
" Count of spaces using with autoindentation
set shiftwidth=4
" Enable smart tabs
set smarttab
" Replace tabs by spaces (also, look on :retab command)
set expandtab
" Set different indentation politics for crontab, fstab, make...
au FileType crontab,fstab,make set noet ts=8 sw=8



""
"" Look and Feel
""
" TTY background - light
set background=light
" Connection with TTY is fast
set ttyfast
" Enable supply of 256 colors
set t_Co=256
" Use blink unstead of bell
set visualbell
" Show matching brackets
set showmatch
" Disable text about Uganda childs in start
set shortmess+=tToOI
" Do not wrap string near end of screen
set wrap
" Do not wrap word - all hyphenation just between words.
set linebreak
" Nice autocomplete
set wildmenu
" New window appears below present window
set splitbelow
" Always show line with tabs
set stal=2
" Maximal count of opened tabs
set tpm=100
" Use ALT key as usual, not for window menu invoke
set wak=yes
" Save size of windows in vim session
set ssop+=resize
" 0-symbol column separator
set colorcolumn=0
" Settings for popup menu
set completeopt=menuone,menu,longest,preview
set wrapmargin=5                        "отступ от текста до правой границы окна
set scrolloff=3                         "Сколько строк показывать при скроллинге сверху и снизу
" Color theme
Bundle 'dim13/xedit.vim'
color xedit
function! ToggleBg()
    if &background == 'dark'
        set bg=light
    else
        set bg=dark
    endif
endfunc
" Startify settings
let g:startify_bookmarks = ['~/.vimrc',]
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 8
let g:startify_skiplist = ['vimrc',]
" Gitgutter settings
set updatetime=100



""
"" Statusline (airline)
""
" Show uncomplete commands
set showcmd
" Disable displaying of mode
set noshowmode
" Show statusline
set laststatus=2
"g:airline_section_a - show mode by default
let g:airline_section_b = '[FORMAT=%{&ff}] [TYPE=%Y]'
let g:airline_section_c = '%f'
let g:airline_section_x = '%{fugitive#statusline()}'
let g:airline_section_y = '[POS=%04l,%04v] %p%%'
let g:airline_section_z = '[LEN=%L]'
let g:airline_theme = 'lucius'
" Disable info about trailing whitespace
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" which sections get truncated at what width
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 79,
  \ 'x': 79,
  \ 'z': 60,
  \ 'c': 45,
  \ 'y': 45,
  \ }


""
"" GUI Settings
""
if has ("gui_running")
    " Use mouse
    set mouse=a                             "используем мышку
    " Disable menu
    set guioptions-=m
    " Disable toolbar
    set guioptions-=T
    " Disable scrollbars
    set guioptions-=r
    set guioptions-=l
    set guioptions-=L
    " Use console dialogs unstead of graphical dialogs
    set guioptions+=c
    " Use antialiasing for fonts
    set antialias
    " Hide mouse cursor
    set mousehide
    " Disable unneeded escape chars in shell
    set noguipty
    " Highlight current line
    set cursorline

    " Set default font and setup window-maximize method for different OSes
    if has("gui_gtk2")
        set guifont=Droid\ Sans\ Mono\ 12
        au GUIEnter * :set lines=99999 columns=99999
    elseif has("gui_win32")
        set guifont=Droid\ Sans\ Mono:h10
        au GUIEnter * :set lines=50 columns=120
    endif
    " Disable cursor blinking
    set guicursor+=a:blinkon0
    " Show tab number
    set guitablabel=%N\ %f\ %M
endif



""
"" Coding
""
"
" <C-c>c -- enable or disable vertical line for 80th character
" <C-c>m -- compile C, C++ or LaTeX source
" <C-c>np -- create new project
" gc -- (un)comment source code
" <C-p>f -- fuzzy search in files
" <C-p>b -- fuzzy search in buffers
" <C-p>c -- fuzzy search in code
"
" format of error string for gcc and sdcc (for errormarker plugin)
let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
" Create new project
menu NewProj.C :!cp -r ~/.vim/mproj/c/* .<CR>:e ./main.c<CR>
menu NewProj.LaTeX_report :!cp -r ~/.vim/mproj/latex-report/* .<CR>:e ./report.tex<CR>
menu NewProj.LaTeX_beamer :!cp -r ~/.vim/mproj/latex-beamer/* .<CR>:e ./presentation.tex<CR>
map <C-c>np :emenu NewProj.<TAB>
" If Makefile present - use make. Unstead - use gcc for current file
function MakeOurProject()
    if filereadable("Makefile")
        set makeprg=make
    else
        set makeprg=gcc\ -Wall\ -o\ %<\ %
    endif
    if &filetype == "TEX"
        set makeprg=latexmk\ -norc\ -pdf\ -time\ %
    elseif &filetype == "MARKDOWN"
        set makeprg=chrome\ %
    endif
    make!
endfunction
" Compile programs using MakeOurProject (and do not jump to first error)
au BufRead,BufNewFile,BufEnter,BufWinEnter *.c,*.h,*.asm imap <C-c>m <Esc>mc:execute MakeOurProject()<CR>`ca
au BufRead,BufNewFile,BufEnter,BufWinEnter *.c,*.h,*.asm nmap <C-c>m mc:execute MakeOurProject()<CR>`c
au BufRead,BufNewFile,BufEnter,BufWinEnter *.tex map <C-c>m mc:execute MakeOurProject()<CR>`c
au BufRead,BufNewFile,BufEnter,BufWinEnter *.md map <C-c>m mc:execute MakeOurProject()<CR>`c
"
let g:tex_flavor = 'latex'
" Enable/disable vertical line for 80th character
function MyColorColumn()
    if &colorcolumn == 80
        set colorcolumn=0
    else
        set colorcolumn=80
    endif
endfunction
imap <C-c>c <Esc>mg:execute MyColorColumn()<CR>`ga
nmap <C-c>c mg:execute MyColorColumn()<CR>`g
" Close popup preview window for omnicompletion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" Pass *.md files as markdown files
autocmd BufNewFile,BufRead *.md set filetype=markdown
" Plugin for CtrlP - can work with functions
let g:ctrlp_extensions = ['ctrlp-funky']
let g:ctrlp_map='<c-p>f'
nmap <C-p>b :CtrlPBuffer<CR>
nmap <C-p>c :CtrlPFunky<CR>
" Curly braces indentation
au BufRead,BufNewFile,BufEnter,BufWinEnter *.c,*.h,*.java inoremap {<CR> {<CR>}<Esc>O



""
"" TagList
""
"
" <C-c>t -- open TagList window
"
" Show info just about one file
let g:Tlist_Show_One_File = 1
" Get focus after opening
let g:Tlist_GainFocus_On_ToggleOpen = 1
"
let g:Tlist_Compact_Format = 1
" Do not close the window after tag selection
let g:Tlist_Close_On_Select = 0
" Highlight tag which corresponding with current position in file
let g:Tlist_Auto_Highlight_Tag = 1
let tlist_tex_settings   = 'latex;s:sections;g:graphics;l:labels'
let tlist_make_settings  = 'make;m:macros;t:targets'
let tlist_markdown_settings = 'markdown;h:headings'
let Tlist_Use_Right_Window = 0



""
"" Python-mode
""
"
" \b -- set breakpoint
" <C-w>o -- maximize current window
" <C-c>rr -- refactor function/method/variable under the cursor
" <C-c>td -- show all TODOs in Python files
"
" Disable line numbers and 80th symbol color column
"let g:pymode_options = 0
"let g:pymode_lint = 1
"let g:pymode_lint_checker = "pyflakes,pep8"
"let g:pymode_lint_ignore = "E501"
"" When user save a file - check code
"let g:pymode_lint_write = 1
"" Disable window with errors and warnings
"let g:pymode_lint_cwindow = 0
"" VirtualEnv support
"let g:pymode_virtualenv = 1
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_key = '<leader>b'
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 1
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
"" Disable autofolding
"let g:pymode_folding = 0
"let g:pymode_python = 'python'
"let g:pymode_indent = 1
"let g:pymode_rope_completion = 1
"let g:pymode_rope_complete_on_dot = 1
"" Find and show all TODOs
"imap <C-c>td <Esc>:noautocmd vimgrep /TODO/j **/*.py<CR>:cw<CR>a
"nmap <C-c>td :noautocmd vimgrep /TODO/j **/*.py<CR>:cw<CR>


""
"" vim-better-whitepace
""
let g:better_whitespace_enabled=1
" Show spaces before or between tabs
let g:show_spaces_that_precede_tabs=1
let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown']



""
"" Keybindings
""
" Close buffer without saving
map <Esc><Esc> :q!<CR>
" Show more (un)useful information rather than <C-g>
map <C-g> g<C-g>
" Open new tab
imap <C-t>t <Esc>:tabnew<CR>a
nmap <C-t>t :tabnew<CR>
" Show/hide line numbers
imap <C-c>n <Esc>:set<Space>nu!<CR>a
nmap <C-c>n :set<Space>nu!<CR>
" Show list of errors
imap <C-c>l <Esc>:copen<CR>
nmap <C-c>l :copen<CR>
" Show/hide taglist
imap <C-c>t <Esc>:TlistToggle<CR>:TlistUpdate<CR>
nmap <C-c>t :TlistToggle<CR>:TlistUpdate<CR>
" Switch between *.c and *.h file (a.vim plugin)
imap <C-c>sw <Esc>:AT<CR>
nmap <C-c>sw :AT<CR>
" Change color theme
imap <C-c>tb <Esc>:call ToggleBg()<CR>a
nmap <C-c>tb :call ToggleBg()<CR>
" Nightmare mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <F1> <NOP>
" Open terminal
map <C-c>i :emenu CMD.<TAB>


"""EOF
