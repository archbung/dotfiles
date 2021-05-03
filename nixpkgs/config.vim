" vim:set ts=2 sts=2 sw=2 et:
"
" Basic settings
"
set scrolloff=5
set splitbelow splitright

" No backup, swap, etc
set noswapfile
set nobackup
set nowritebackup

set hidden         " Don't nag about abandoned buffer
set shortmess+=c   " Disable messages about completions
set updatetime=300
set cpoptions+=J   " A sentence must be followed by two spaces
set signcolumn=yes

set number
set showcmd
set showmatch      " Highlight matching brackets on cursor hover

" File formats and encoding
set fileformats=unix,dos,mac
set encoding=utf-8

" Searching
set hlsearch
set incsearch      " Incremental search
set ignorecase
set smartcase      " Ignore case only if there's no capital letter in search

" Enhance command-line completion
set wildmenu
set wildmode=list:longest,full

set cmdheight=2    " Taller command line

" Colors
set termguicolors
colorscheme onedark


"
" Keybindings
"
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"
nnoremap j gj
nnoremap k gk
tnoremap <C-[> <C-\><C-n>

" fzf.vim keybindings
nnoremap <leader>ff :Files ~<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>sr :Rg<CR>
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gc :Commits<CR>

augroup general
  autocmd!
  autocmd VimResized * wincmd =
  " Save cursor position in a file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
augroup END
