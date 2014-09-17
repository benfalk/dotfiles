set nocompatible
filetype off

let mapleader = ","
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'slim-template/vim-slim.git'
Plugin 'airblade/vim-gitgutter'
Plugin 'gmarik/vundle'
Plugin 'thoughtbot/vim-rspec'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'L9'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'

filetype on
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Vim Pathogen Package Manager
execute pathogen#infect()

" Awesome colorscheme https://raw.github.com/Lokaltog/vim-distinguished/develop/colors/distinguished.vim
colorscheme distinguished

" Tabs
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent

nnoremap ; :

" Remap escape to 'jj'
inoremap jj <ESC>
"nmap tt :tabn<CR>
"nmap pt :tabp<CR>
nmap qq :q<CR>
"nmap ww :w<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Tab Over Son
map <Leader><TAB> :tabn<CR>

" Always show line numbers please
set nu

map <F2> :NERDTreeToggle<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" search and syntax highlighting
syntax enable
set hlsearch
set incsearch

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
