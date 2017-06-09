" .vimrc

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
Plugin 'wincent/command-t'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jason0x43/vim-js-indent'
Plugin 'mattn/emmet-vim'
Plugin 'motemen/git-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mileszs/ack.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'
Plugin 'vim-scripts/SyntaxComplete'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'raimondi/delimitMate'
call vundle#end()

" Syntax highlighting

" Detect filetype
filetype plugin indent on

" Enable syntax highlightning
syntax enable

" Display line for cursor
set nocursorline

" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51

" ...but absolute numbers on the current line (hybrid numbering)
set number

" Set relative line numbers...
set norelativenumber

set regexpengine=0
let g:netrw_liststyle = 3

highlight Comment cterm=italic
highlight htmlArg cterm=italic
" Ensure that italics carry over if I ever switch light/dark scheme
" autocmd ColorScheme * highlight! Comment cterm=italic
" autocmd ColorScheme * highlight! htmlArg cterm=italic

" Tell Vim to look in my home directory for more ctags
set tags+=tags;$HOME

" Set relevant filetypes
"au BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.hbs set filetype=html

" Optimize for fast terminal connections
set ttyfast

set spell

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
set autochdir
" set path+=**
" Show file options above the command line
set wildmenu
" Don’t offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" Disable indentLine by default
let g:ackprg = 'ag --nogroup --nocolor --column'

let NERDTreeShowHidden=1
set showcmd
set laststatus=2  " Always display the status line

set numberwidth=3
set lazyredraw
set wildignore+=**/node_modules   " ignores node_modules
set wildignore+=**/spec/reports   " ignores spec/reports
set ruler                         " show current position
set showmode                      " show what mode we're currently editing in
set showmatch                     " show matching brackets
set clipboard+=unnamed            " yanks to clipboard
set nospell                       " no spell checking
set wrap!                         " no word wrapping

" theme
set background=dark
set t_Co=256
let g:solarized_termtrans=1
let g:solarized_bold = 1
let g:solarized_underline = 1
let g:solarized_italic = 1
let g:solarized_contrast = "normal"
let g:solarized_visibility= "normal"
colorscheme solarized
call togglebg#map("<F3>")

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set scrolloff=3                   " number of lines to keep off the edges of the screen when scrolling
set sidescrolloff=5
set textwidth=80                 " force the cursor onto a new line after 80 characters
set wrapmargin=0
set whichwrap=h,l,b,<,>,~,[,]
set autoindent                    " always set autoindenting on
set copyindent                    " copy indentation on new lines
set smartindent                   " indent on new blocks
" Write swapfiles to disk a little sooner
set updatetime=250
" Allow modelines
set modeline
set expandtab                     " expand tabs by default (overloadable per file type later)
set smarttab                      " insert tabs on the start of a line according to shiftwidth, not tabstop
set tabstop=2                     " tab spaces size
set laststatus=2                  " Always display the status line
set title                         " Show file title in terminal tab
set softtabstop=2                 " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                  " number of spaces to use for autoindenting
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'

set noignorecase                  " do not ignore case when searching
set nogdefault                    " do not search/replace 'globally' (on a line) by default
set smartcase                     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                    " don't keep results highlighted after searching
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
set history=50

set incsearch                     " show search matches as you type
set wildmenu                      " show list instead of just completing
set wildmode=list:longest,full    " command <Tab> completion, list matches, then longest common part, then all

set wrapmargin=0

" Colour the column just after our line limit so that we don’t type over it
set colorcolumn=+1

" HTML Editing
set matchpairs+=<:>
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Setup gitgutter plugin
let g:gitgutter_sign_column_always = 1

" F2 before pasting to preserve indentation
set pastetoggle=<F2>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" However, in Git commit messages, let’s make it 72 characters
autocmd Filetype gitcommit setlocal spell textwidth=72

" auto change the directory to the current file I am currently editing
autocmd BufEnter * lcd %:p:h

" Custom status line
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
 " set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
" set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\

" Key mappings
" jj to throw you into normal mode from insert mode
inoremap jj <Esc>
" jk to throw you into normal mode from insert mode
inoremap jk <Esc>

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

" Map ctrl+n to toggle NERDTree
map <C-n> :NERDTreeToggle<cr>

" tab navigati>on mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

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
map <Leader>i mzgg=G`z

" Abbreviations and auto-completions

" lipsum<Tab> drops some Lorem ipsum text into the document
iab lipsum Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.

