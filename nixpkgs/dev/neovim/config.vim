" vim:set ts=2 sts=2 sw=2 et:
"
" Basic settings
"
set scrolloff=5
set noshowmode
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
" Plugins
"
" Polyglot
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_classic_highlighting = 1

" FZF
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS = "--layout=reverse"

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

" Vimtex
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"

" Lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [[ 'mode', 'paste', ],
      \            [ 'gitbranch', 'readonly', 'filename', ]],
      \   'right':
      \     [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', ],
      \      [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ]]
      \   },
      \ 'component_function': {
      \   'gitbranch': 'fugitve#head',
      \   'filename': 'LightlineFilename',
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

" Snippets
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-b>"

" Ale
let g:ale_fixers = {
      \   '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
      \   'haskell': [ 'stylish-haskell' ],
      \   'nix': [ 'nixpkgs-fmt' ],
      \ }
let g:ale_fix_on_save = 1

let g:ale_linters = {
      \   'haskell': [ 'hlint' ],
			\ }


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
nnoremap <leader>fr :History<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>sr :Rg<CR>

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>

"
" Autocmd
"
au BufNewFile,BufRead *.spthy setf spthy
