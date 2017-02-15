syntax enable
set tabstop=2
set softtabstop=2
set expandtab
set showcmd
filetype indent on
set wildmenu 
set lazyredraw  
set showmatch
set incsearch
set hlsearch  

command! ppjson %!python -m json.tool
command! pphtml !tidy -mi -html -wrap 0 %
command! ppxml !tidy -mi -xml -wrap 0 %
