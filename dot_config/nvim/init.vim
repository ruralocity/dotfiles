" Use minpac plugin manager
packadd minpac      
call minpac#init()

set number " show line numbers
set cursorline

" Keyboard mappings
inoremap jk <esc> " jk is escape
nnoremap <C-p> :<C-u>FZF<CR>

" indenting
filetype plugin indent on
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set tabstop=2
set backspace=indent,eol,start  " backspace through everything in insert mode
