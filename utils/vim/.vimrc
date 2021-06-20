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
""" *) vim-better-whitespace
""" *) Keybindings



""
"" General
""
set runtimepath+=~/.vim
set nocompatible
filetype plugin indent on
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
" Enable syntax highlighting
syntax on
" Reread .vimrc after write
autocmd! bufwritepost $VIM/.vimrc execute "normal! :source $VIM/.vimrc"
" Switch to last known cursor position in opened file.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
" To fix bug with executing code from modeline
set modelines=0
" Use filetype=mail with mutt
augroup filetypedetect
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END



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
" Ignore case, but not ignore when capital letter meets
set ignorecase
set smartcase




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
" Disable text about Uganda children at start
set shortmess+=atToOI
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
" Highlight by invert colors
set highlight-=v:Visual
set highlight+=vr
set highlight+=sr
" Settings for popup menu
set completeopt=menuone,menu,longest,preview
set wrapmargin=5                        "отступ от текста до правой границы окна
set scrolloff=3                         "Сколько строк показывать при скроллинге сверху и снизу
" Show changing text
set cpoptions+=$
" Use nicer algorithm for diff
set diffopt+=indent-heuristic,algorithm:histogram
" Color theme
color xedit
function! ToggleBg()
    if &background == 'dark'
        set bg=light
    else
        set bg=dark
    endif
endfunc
" Gitgutter settings
set updatetime=100
" Set gitgutter background color as line number column background
highlight clear SignColumn
" Fix window sizes when window manager resize it
autocmd VimResized * wincmd =
" Update vim title for X11 and tmux
set titleold = ""
set title
autocmd BufEnter * let &titlestring = expand("%:t")



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
let g:airline_section_b = '[FMT=%{&ff}] [TYPE=%Y]'
let g:airline_section_c = '%f'
let g:airline_section_x = ''
let g:airline_section_y = '[%04l,%04v] %p%%'
let g:airline_section_z = '[LEN=%L]'
let g:airline_theme = 'papercolor'
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

    " Set default font and setup window-maximize method
    set guifont=Droid\ Sans\ Mono\ 12
    au GUIEnter * :set lines=99999 columns=99999
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
"
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
" Curly braces indentation
au BufRead,BufNewFile,BufEnter,BufWinEnter *.c,*.h,*.java inoremap {<CR> {<CR>}<Esc>O
" Smart work with comments:
"  Append comments symbol
"  Proper concatenate comments with J
set formatoptions=croqlnj



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
" Fix typos
map q: :
command! W w
" Jump over spaces
nmap <space> f<space>
" Jump over _
nmap _ f_l

"""EOF

