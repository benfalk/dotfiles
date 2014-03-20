set nocompatible
filetype off

let mapleader = ","
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'thoughtbot/vim-rspec'
Bundle 'L9'
Bundle 'FuzzyFinder'

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

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Fuzzy Finder mappings
map <Leader>f :FufFile<CR>

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
