set nocompatible
" Use UTF-8 by default
set encoding=utf-8
set fileencoding=utf-8

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'mileszs/ack.vim'
Plug 'tomtom/tlib_vim'
Plug 'sbdchd/neoformat'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'othree/html5.vim'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'ajh17/VimCompletesMe'
" Plug 'w0rp/ale'
Plug 'dracula/vim'
" Initialize plugin system
call plug#end()

filetype plugin indent on
syntax enable
set nocursorline

let g:ctrlp_mruf_relative = 1
let MRU_Max_Menu_Entries = 50
let g:ctrlp_path_nolim = 1

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_column_always = 1

map <C-n> :NERDTreeToggle<CR>

" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51
autocmd FileType gitcommit set colorcolumn+=73
autocmd BufEnter * :syntax sync fromstart

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow


set number
set relativenumber

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
  let g:ackprg = 'ag --nogroup --nocolor --column'
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:netrw_liststyle = 3

highlight Comment cterm=italic
highlight htmlArg cterm=italic
highlight ColorColumn ctermbg=0
" Ensure that italics carry over if I ever switch light/dark scheme
" autocmd ColorScheme * highlight! Comment cterm=italic
" autocmd ColorScheme * highlight! htmlArg cterm=italic
"
" autocmd BufEnter * :syntax sync fromstart

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
      \ 'exe': 'pg_format',
      \ 'args': ['-s 4', '-f 2', '-u 2', '-'],
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
set nospell

" Underscores denote words
" set iskeyword-=_
" No extra spaces when joining lines
set nojoinspaces
" Interpret numbers with leading zeroes as decimal, not octal
set nrformats-=octal
" Auto-format comments
" set formatoptions+=jroqn1

" Buffer management

" Open splits to the right or below; more natural than the default
set splitright
set splitbelow
" set path+=**
" Don’t offer to open certain files/directories
set wildignore+=.DS_Store,*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/storage/*
set wildignore+=/*public/*
set wildignore+=*/dist/*
set wildignore+=*/bower_components/*

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=35
let NERDTreeIgnore=['\.DS_Store', 'node_modules', 'bower_components', '\.idea', '\.git']
" set showcmd

set lazyredraw
set showmode                      " show what mode we're currently editing in
" set showmatch                     " show matching brackets
set clipboard+=unnamed            " yanks to clipboard
set nospell                       " no spell checking
set nowrap                        " no lines wrapping

" theme
set background=dark

if has("gui_running")
  " Macvim
  set guifont=Monaco:h12
  set linespace=15
  set visualbell t_vb=
  set guioptions-=T " Removes top toolbar
  set guioptions-=r " Removes right hand scroll bar
  set go-=L " Removes left hand scroll bar
  colorscheme dracula
  " Automatically save the session when leaving Vim
  autocmd! VimLeave * mksession! session.vim
  " Automatically load the session when entering vim
  if !empty(glob("session.vim"))
    autocmd! VimEnter * source session.vim
  endif
else
  set t_Co=256
  set background=dark
  colorscheme dracula
endif

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set wrapmargin=0
set whichwrap=h,l,b,<,>,~,[,]
set autoindent                    " always set autoindenting on
set copyindent                    " copy indentation on new lines
set smartindent                   " indent on new blocks
set expandtab                     " expand tabs by default (overloadable per file type later)
set smarttab                      " insert tabs on the start of a line according to shiftwidt', not tabstop
set tabstop=2                     " tab spaces size
set laststatus=2                  " Always display the status line
set softtabstop=2                 " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                  " number of spaces to use for autoindenting
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'

set noignorecase                  " do not ignore case when searching
set nogdefault                    " do not search/replace 'globally' (on a line) by default
set smartcase                     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                      " don't keep results highlighted after searching
set incsearch                     " highlight as we type
set showmatch

set statusline=%<%F\ %h%m%r%y%=%-14.(%l,%c%V%)\ %P

" set autoread
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

" display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set nobackup
set nowritebackup
set noswapfile
set backupcopy=yes " it should save file by writing direcrtly to a file

" history and undo levels
set history=1000
set undolevels=1000

set incsearch                     " show search matches as you type
set wildmenu                      " show list instead of just completing
set wildmode=list:longest,full    " command <Tab> completion, list matches, then longest common part, then all

" Colour the column just after our line limit so that we don’t type over it
" set colorcolumn=+1

set nomodeline                  " disable mode lines (security measure)

" HTML Editing
" set matchpairs+=<:>
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" However, in Git commit messages, let’s make it 72 characters
autocmd Filetype gitcommit setlocal spell textwidth=72

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

" when you forgot to sudo before editing a file that requires root privileges
cmap w!! w !sudo tee % >/dev/null

" navigate windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Ctrl+c in visual mode sends selection to clipboard v
noremap <C-c> "*y

" indentation
map <leader>i mzgg=G`z

" Format file with Neoformat
map <leader>m :Neoformat<CR>

" assign buffer list and most recent used with ctrlp plugin
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

