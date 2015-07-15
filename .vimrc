" don't be backwards compatabile with vi
" which enables features that only with in vim
set nocompatible

" figure what a file is so we can highlight synax
filetype on
filetype plugin on
filetype indent on

" read the modeline from the file
set modeline

" syntax highlighting on
syntax on

" show the mode I'm in
set showmode

" better command line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" highlight everything that matches my search pattern
set hlsearch

" search as I type
set incsearch

" Always display the status line, even if only one window is displayed
set laststatus=2

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" don't make backup or .swp files
set nobackup
set noswapfile

" I have a fast terminal, send as much stuff as you want
set ttyfast
