call plug#begin()
  " A better visual status line
  Plug 'vim-airline/vim-airline'

  " Move back and forth from tmux panes and vim panes
  Plug 'christoomey/vim-tmux-navigator'

  " Filebar on the side with git status of changes
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " completes ruby and elixir statements automatically
  Plug 'tpope/vim-endwise'

  " elixir syntax
  Plug 'elixir-lang/vim-elixir'
  Plug 'slashmili/alchemist.vim'

  " markdown highlighting
  Plug 'plasticboy/vim-markdown'

  " show in the line-number gutter git line status
  Plug 'airblade/vim-gitgutter'

  " dynamic fuzzy file-find and open
  Plug 'kien/ctrlp.vim'

  " highlights next letter matches and the 'f' key jumps to them
  Plug 'rhysd/clever-f.vim'

  " Erlang syntax highlights
  Plug 'vim-erlang/vim-erlang-runtime'

  " Great git plugin
  Plug 'tpope/vim-fugitive'

  " elm language support
  Plug 'elmcast/elm-vim'

  " linting languages for faster error feedback
  Plug 'neomake/neomake'

  " autocompletion
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
call plug#end()

" Let's see those sexy powerline fonts!
let g:airline_powerline_fonts = 1

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme distinguished

" Always show statusline
set laststatus=2

" the almighty leader, vanilla coma
let mapleader = ","

nmap qq :q<CR>

" 'jj' in Insert mode escapes back to normal mode
inoremap jj <ESC>

" I want tabs to complete
inoremap <silent> <expr> <Tab> utils#tabComplete()

" Don't let the mouse click jump your cursor
set mouse-=a

" Tabs the sane way
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent

" Copy and paste a little easier from global buffer
map <leader>y "+y
map <leader>p "+p

" clever-f does a better job and I hate pressing shift so much
nnoremap ; :

" On saving a file lint it and automatically open error window
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2

" No swaps
set nobackup
set nowritebackup
set noswapfile

" Strait to the githubs!
map <leader>g :Gbrowse<CR>
map <leader>b :Gblame<CR>
vmap <leader>g :Gbrowse<CR>

" clever-f does a better job and I hate pressing shift so much
nnoremap ; :

" Use deoplete.
let g:deoplete#enable_at_startup = 1

map <F2> :NERDTreeToggle<CR>

" quick way to un-highlight in normal mode
nnoremap <CR> :noh<CR><CR>

" Always show line numbers please
set nu

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore=db/*seeds/\ --ignore=spec/*.yml\ --ignore=*.csv\ --ignore=tmp/

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
