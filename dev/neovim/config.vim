" vim:set ts=2 sts=2 sw=2 et:
"
" Plugins
"
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

" Essentials
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-plug'

" Finding things
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let $FZF_DEFAULT_OPTS = "--layout=reverse"

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ }
  call nvim_open_win(buf, v:true, opts)
endfunction

command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim'

Plug 'sheerun/vim-polyglot'
let g:haskell_classic_highlighting = 1
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode = 1

Plug 'dense-analysis/ale'
let g:ale_fixers = {
      \   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
      \   'haskell': [ 'stylish-haskell' ],
      \   'nix': [ 'nixpkgs-fmt' ],
      \ }

let g:ale_linters = {
      \   'haskell': [ 'hlint' ],
      \ }

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-b>"
let g:UltiSnipsJumpBackwardTrigger = "<C-z>"

Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'psliwka/vim-smoothie'
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [[ 'mode', 'paste', ],
      \            [ 'gitbranch', 'readonly', 'filename', ]],
      \   'right':
      \     [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', ],
      \      [ 'lineinfo'], [ 'percent' ], [ 'filetype']]
      \   },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename' : 'LightlineFilename',
      \   },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \   },
      \ 'component_type': {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \   },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

set noshowmode

call plug#end()


"
" Basic settings
"
set scrolloff=5
set splitright splitbelow
set cpoptions+=J
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

set noswapfile
set nobackup
set nowritebackup

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

nnoremap <leader>\ :NERDTreeToggle<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>sr :Rg<CR>
nnoremap <leader>gs :Gstatus<CR>

nnoremap <localleader>f :ALEFix<CR>


"
" Autocmd
"
au BufNewFile,BufRead *.spthy setf spthy
