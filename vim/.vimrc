set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" python autocomplete w/ jedi
Plugin 'davidhalter/jedi-vim'
" vim airline w/ themes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" NERD Tree file explorer
Plugin 'scrooloose/nerdtree'
" vim-go
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

syntax enable
set exrc
set background=dark
set secure

highlight clear LineNr
colors gruvbox 
set t_Co=256
set ai
set esckeys
set number
set hlsearch
set mouse=a
set nostartofline
set ruler
set showmode
set title
set laststatus=2
set noshowmode
set autowrite " writes contents whenever you call :make, used in go-vim
let g:airline_theme='neodark'

"go-vim keybindings
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
let g:go_list_type = "quickfix"
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

set bs=2
set expandtab
set tabstop=2
set shiftwidth=2
set shiftwidth=2

" NERD Tree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
