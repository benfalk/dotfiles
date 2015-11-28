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
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'jimenezrick/vimerl'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-endwise'
Plugin 'mtth/scratch.vim'
Plugin 'rhysd/clever-f.vim'
Plugin 'benfalk/vim-eunit'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'elixir-lang/vim-elixir'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-projectionist'
Plugin 'junegunn/goyo.vim'
Plugin 'BjRo/vim-extest'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'rust-lang/rust.vim'

call vundle#end()

filetype on
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Vim Pathogen Package Manager
execute pathogen#infect()

" I'm tired of looking at these, no more please
set nobackup
set nowb
set noswapfile

" Awesome colorscheme https://raw.github.com/Lokaltog/vim-distinguished/develop/colors/distinguished.vim
colorscheme distinguished

" No clutter please, I need to focus
let g:goyo_width = 120
map <Leader>G :Goyo<CR>
function! s:goyo_enter()
  if exists('$TMUX')
    silent !tmux set status off
    silent !tmux resize-pane -Z
  endif
endfunction

function! s:goyo_leave()
  if exists('$TMUX')
    silent !tmux set status on
    silent !tmux resize-pane -Z
  endif
endfunction

autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()

" Scratchpad Niceness
let g:scratch_autohide = 1
map <Leader>R :Scratch<CR>

" Strait to the githubs!
map <leader>g :Gbrowse<CR>
map <leader>b :Gblame<CR>
vmap <leader>g :Gbrowse<CR>

" grep word under cursor
nnoremap <Leader>fw :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore=db/*seeds/\ --ignore=spec/*.yml\ --ignore=*.csv\ --ignore=tmp/

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

" Tabs
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent

" Pressing ,S will toggle and untoggle spell checking
map <leader>S :setlocal spell!<cr>

" Toggle wordwrap on and off
map <leader>w :setlocal wrap!<cr>

" clever-f does a better job and I hate pressing shift so much
nnoremap ; :

" Remap escape to 'jj'
inoremap jj <ESC>
"nmap tt :tabn<CR>
"nmap pt :tabp<CR>
nmap qq :q<CR>
"nmap ww :w<CR>

" Will allow you to use :w!! to write to a file using sudo if you forgot to sudo
" vim file (it will prompt for sudo password when writing)
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks/96492#96492
cmap w!! %!sudo tee > /dev/null %

" Test Suite Mappings
map <Leader>t :call TestCurrentFile()<CR>
map <Leader>s :call TestNearest()<CR>
map <Leader>l :call RunLastTest()<CR>
map <Leader>a :call TestAll()<CR>

function! TestCurrentFile()
  if &filetype=="ruby"
    execute ":call RunCurrentSpecFile()"
  elseif &filetype=="erlang"
    execute ":call EunitCurrentFile()"
  elseif &filetype=="elixir"
    execute ":ExTestRunFile"
  else
    echoe "Unkown filetype to test [".&filetype."]"
  end
endfunction

function! TestNearest()
  if &filetype=="ruby"
    execute ":call RunNearestSpec()"
  elseif &filetype=="erlang"
    execute ":call EunitNearestTest()"
  elseif &filetype=="elixir"
    execute ":ExTestRunTest"
  else
    echoe "Unkown filetype to test [".&filetype."]"
  end
endfunction

function! RunLastTest()
  if &filetype=="ruby"
    execute ":call RunLastSpec()"
  elseif &filetype=="erlang"
    execute ":call EunitLastCommand()"
  elseif &filetype=="elixir"
    execute ":ExTestRunLast"
  else
    echoe "Unkown filetype to test [".&filetype."]"
  end
endfunction

function! TestAll()
  if &filetype=="ruby"
    execute ":call RunAllSpecs()"
  elseif &filetype=="erlang"
    execute ":call EunitTestAll()"
  elseif &filetype=="elixir"
    execute ":!mix test"
  else
    echoe "Unkown filetype to test [".&filetype."]"
  end
endfunction

" Copy and paste a little easier from global buffer
map <leader>y "+y
map <leader>p "+p

" Tab Over Son
map <Leader><TAB> :tabn<CR>

" Always show line numbers please
set nu

map <F2> :NERDTreeToggle<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" I really like following the 80 columns rule with markdown
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown setlocal textwidth=80

" search and syntax highlighting
syntax enable
set hlsearch
set incsearch

" quick way to un-highlight in normal mode
nnoremap <CR> :noh<CR><CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
