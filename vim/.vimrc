" .vimrc
"

" Setup

" Use Vim features, not Vi
set nocompatible
" Use UTF-8 by default
set encoding=utf-8
set fileencoding=utf-8
" Let's use Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'pangloss/vim-javascript'
Plugin 'mileszs/ack.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'sbdchd/neoformat'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-commentary'
Plugin 'leafgarland/typescript-vim'
Plugin 'cohama/lexima.vim'
Plugin 'ajh17/VimCompletesMe'
Plugin 'w0rp/ale'
call vundle#end()

" Syntax highlighting

" Detect filetype
filetype plugin indent on

" Enable syntax highlightning
syntax enable

" Display line for cursor
set nocursorline

let g:ctrlp_mruf_relative = 1
let MRU_Max_Menu_Entries = 50
let g:ctrlp_path_nolim = 1

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

map <C-n> :NERDTreeToggle<CR>

" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51
autocmd FileType gitcommit set colorcolumn+=73
autocmd BufEnter * :syntax sync fromstart

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" this
set nonumber
set norelativenumber

" Fix pasting when using tmux
set clipboard=unnamed
" let c_minlines=1000

" syntax sync minlines=2000

set hidden                      " hide buffers instead of closing them this
"    means that the current buffer can be put
"    to background without being written; and
"    that marks and undo history are preserved

" Faster escape timeout
set timeoutlen=1000 ttimeoutlen=0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set regexpengine=0
let g:netrw_liststyle = 3

highlight Comment cterm=italic
highlight htmlArg cterm=italic
highlight ColorColumn ctermbg=0
" Ensure that italics carry over if I ever switch light/dark scheme
" autocmd ColorScheme * highlight! Comment cterm=italic
" autocmd ColorScheme * highlight! htmlArg cterm=italic
"
" autocmd BufEnter * :syntax sync fromstart

" Tell Vim to look in my home directory for more ctags
set tags+=tags;

autocmd FileType javascript setlocal formatprg=prettier\ --parser\ flow\ --single-quote\ --stdin
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript\ --single-quote\ --stdin
autocmd FileType css setlocal formatprg=prettier\ --parser\ postcss\ --stdin
autocmd FileType scss setlocal formatprg=prettier\ --parser\ postcss\ --stdin
autocmd FileType less setlocal formatprg=prettier\ --stdin
autocmd FileType json setlocal formatprg=prettier\ --stdin

" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

" Have Neoformat use &formatprg as a formatter
let g:neoformat_try_formatprg = 1

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neoformat_sql_sql = {
      \ 'exe': 'sqlformat',
      \ 'args': ['--reindent', '--keywords upper', '-'],
      \ 'stdin': 1,
      \ }

let g:neoformat_enabled_sql = ['sql']
let g:neoformat_verbose = 0

let g:ctrlp_root_markers = ['.ctrlp']

" Set relevant filetypes
"au BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.hbs set filetype=html
autocmd BufNewFile,BufRead *.html set ft=html

" Optimize for fast terminal connections
set ttyfast
set ttyscroll=3

set nospell

" Jsdoc plugin
let g:used_javascript_libs = 'jquery,underscore,backbone,react,lo-dash'
let g:javascript_plugin_jsdoc = 1

" Underscores denote words
set iskeyword-=_
" No extra spaces when joining lines
set nojoinspaces
" Interpret numbers with leading zeroes as decimal, not octal
set nrformats-=octal
" Auto-format comments
set formatoptions+=jroqn1


" Buffer management

" Open splits to the right or below; more natural than the default
set splitright
set splitbelow
" Set the working directory to wherever the open file lives (can be problematic)
" set autochdir
set path+=**
" Don’t offer to open certain files/directories
set wildignore+=.DS_Store,*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/storage/*
set wildignore+=/*public/*
set wildignore+=*/dist/*
set wildignore+=*/bower_components/*

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=35
let NERDTreeIgnore=['\.DS_Store', 'node_modules', 'bower_components', '\.idea', '\.git']
set showcmd

set numberwidth=3
set lazyredraw
set ruler                         " show current position
set showmode                      " show what mode we're currently editing in
set showmatch                     " show matching brackets
set clipboard+=unnamed            " yanks to clipboard
set nospell                       " no spell checking
set nowrap                        " no lines wrapping

" theme
set background=dark

if has("gui_running")
  " Macvim
  set guifont=Monaco:h13
  set linespace=15
  set visualbell t_vb=
  set guioptions-=T " Removes top toolbar
  set guioptions-=r " Removes right hand scroll bar
  set go-=L " Removes left hand scroll bar
  colorscheme base16-material
  " Automatically save the session when leaving Vim
  autocmd! VimLeave * mksession! session.vim
  " Automatically load the session when entering vim
  if !empty(glob("session.vim"))
    autocmd! VimEnter * source session.vim
  endif
  set number
  set relativenumber
else
  set t_Co=256
  let g:solarized_termtrans=1
  let g:solarized_bold = 1
  let g:solarized_underline = 1
  let g:solarized_italic = 1
  let g:solarized_contrast = "normal"
  let g:solarized_visibility= "normal"
  colorscheme solarized
endif

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set scrolloff=3                   " number of lines to keep off the edges of the screen when scrolling
set sidescrolloff=5
set textwidth=100                 " force the cursor onto a new line after 100 characters
set wrapmargin=0
set whichwrap=h,l,b,<,>,~,[,]
set autoindent                    " always set autoindenting on
set copyindent                    " copy indentation on new lines
set smartindent                   " indent on new blocks
" Write swapfiles to disk a little sooner
" set updatetime=250
set expandtab                     " expand tabs by default (overloadable per file type later)
set smarttab                      " insert tabs on the start of a line according to shiftwidt', not tabstop
set tabstop=2                     " tab spaces size
set laststatus=0                  " Always display the status line
set title                         " Show file title in terminal tab
set softtabstop=2                 " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                  " number of spaces to use for autoindenting
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'

set noignorecase                  " do not ignore case when searching
set nogdefault                    " do not search/replace 'globally' (on a line) by default
set smartcase                     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                      " don't keep results highlighted after searching
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
set incsearch                     " highlight as we type
set showmatch

set autoread
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

" display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set nobackup
set nowritebackup
set noswapfile
set backupcopy=yes " it should save file by writing direcrtly to a file

" history and undo levels
" set history=1000
" set undolevels=1000

set incsearch                     " show search matches as you type
set wildmenu                      " show list instead of just completing
set wildmode=list:longest,full    " command <Tab> completion, list matches, then longest common part, then all

set wrapmargin=0

" Colour the column just after our line limit so that we don’t type over it
" set colorcolumn=+1

set nomodeline                  " disable mode lines (security measure)

" HTML Editing
set matchpairs+=<:>
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" F2 before pasting to preserve indentation
set pastetoggle=<F2>

" However, in Git commit messages, let’s make it 72 characters
autocmd Filetype gitcommit setlocal spell textwidth=72

" auto change the directory to the current file I am currently editing
" autocmd BufEnter * lcd %:p:h

" Key mappings
"
" change the mapleader from \ to ,
let mapleader=","

" jj to throw you into normal mode from insert mode
inoremap jj <Esc>

" break a line in normal mode
nnoremap <NL> i<CR><ESC>

" `gb` switches to next buffer, like `gt` does with tabs
nnoremap gb :bn<CR>
" `gB` switches to previous buffer, like `gT` does with tabs
nnoremap gB :bp<CR>
" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>
" `gF` opens file under cursor in a new split
nnoremap gF <C-w>f
" Toggle `hlsearch` with <Space>/
nnoremap <Leader>/ :set hlsearch!<CR>
" Make tabbing persistent in visual mode
vnoremap <Tab> >gv
" Toggle pasting mode
nnoremap <Leader>p :set paste!<CR>
" Toggle light/dark backgrounds
nnoremap <Leader>bg :let &background = (&background == "dark" ? "light" : "dark")<CR>
" Strip trailing whitespace
nnoremap <Leader>ws :%s/ \+$//<CR>
" Convert tabs to spaces
nnoremap <Leader>rt :retab<CR>

" vertical or horizontal split and fuzzy search
nnoremap <Leader>p :e **/*
nnoremap <Leader>v :vsplit **/*
nnoremap <Leader>s :split **/*

inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" This turns off Vim’s crazy default regex chars and makes searches use normal regexes
nnoremap / /\v
vnoremap / /\v

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" when you forgot to sudo before editing a file that requires root privileges
cmap w!! w !sudo tee % >/dev/null

" navigate windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Ctrl+c in visual mode sends selection to clipboard v
noremap <C-c> "*y

" Switch to previous window
nnoremap <Leader>` <C-w><C-p>

" A quick way to move lines of text up or down
" In normal mode or in insert mode, press Alt-j to move the current line down,
" or press Alt-k to move the current line up.
" After visually selecting a block of lines (for example, by pressing V then
" moving the cursor down), press Alt-j to move the whole block down, or press
" Alt-k to move the block up.
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" indentation
map <leader>i mzgg=G`z

" Format file with Neoformat
map <leader>m :Neoformat<CR>

" assign buffer list and most recent used with ctrlp plugin
nnoremap <silent> <leader>e :CtrlPMRU<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'

let g:user_emmet_install_global = 0
autocmd BufRead,BufNewFile *.blade.php set filetype=html
autocmd FileType html,htmldjango,css,scss EmmetInstall

" Handy command-line mode
nnoremap ; :
" <Esc> is too annoying to type
inoremap jkj <Esc>
" Screen sucks, redraw everything
nnoremap <Leader>r :redraw!<CR>
" Make Q meaningless (Q: Entering to Ex mode)
nnoremap Q <nop>

" format pasted text automatically and correct bad indent while pasting
:nnoremap p p=`]
" perform normal paste without indenting

noremap <leader>/ :Commentary<cr>
" Sane CTRL-l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"

command! Q q
command! W w

" Close all buffers except this one
command! BufCloseOthers %bd|e#

" Abbreviations and auto-completions

" lipsum<Tab> drops some Lorem ipsum text into the document
iab lipsum Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.

