call plug#begin('~/.vim/plugged')
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'morhetz/gruvbox'
"Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline', { 'tag': 'v0.9' }
Plug 'vim-airline/vim-airline-themes'
"Plug 'kien/ctrlp.vim'
"Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
"Plug 'maxmellon/vim-jsx-pretty'
"Plug 'neoclide/vim-jsx-improve'
Plug 'tpope/vim-fugitive', { 'tag': 'v2.3' }
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'



" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

syntax enable
colorscheme gruvbox
set background=dark
set termguicolors
set t_Co=256
set backspace=2 " backspace over new lines
set autoindent
set lazyredraw
set hidden
set number " show line numbers
set incsearch " search as characters are entered
set hlsearch " highlight matches
set nostartofline
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/* " lol
set clipboard=unnamed " use os clipboard
set cursorline " highlight current line
set noswapfile
set noshowmode " let airline do the work
set shortmess+=c " don't give |ins-completion-menu| messages.

"  tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab


" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes


"handy keymaps
let mapleader="\<Space>"
"save current buffer
nnoremap <leader>w :w<cr>
"close current buffer
nnoremap <leader>bq :bp <bar> bd! #<cr>
"close all open buffers
nnoremap <leader>ba :bufdo bd!<cr>
"Tab to switch to next open buffer
nnoremap <Tab> :bnext<cr>
"Shift + Tab to switch to previous open buffer
nnoremap <S-Tab> :bprevious<cr>
"leader key twice to cycle between last two open buffers
nnoremap <leader><leader> <c-^>
"move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction


" vim-go
" navigating errors in quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

" ctrlp
"et g:ctrlp_map = '<c-p>'
"et g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'
" Open hotkeys
map <C-p> :GFiles<CR>
nmap <leader>; :Buffers<CR>

" airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" unicode symbols
set laststatus=2 " for airline

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" switch to left / right split (mostly for Nerd Tree)
map <C-h> <C-W>h
map <C-l> <C-W>l

" YCM Settings
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_autoclose_preview_window_after_completion = 1

" NERD Tree settings
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " autoquit if only nerdtree is open
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"nnoremap <Leader>f :NERDTreeToggle<Enter>
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
"let NERDTreeShowHidden = 1

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' navigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100
