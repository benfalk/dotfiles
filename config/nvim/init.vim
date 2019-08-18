call plug#begin()
  " A better visual status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

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
  Plug 'mhinz/vim-mix-format'

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

  " Rust Support
  Plug 'rust-lang/rust.vim'

  " Vue Code Highlighting
  Plug 'posva/vim-vue'

  " elm language support
  Plug 'elmcast/elm-vim'

  " C# language support
  Plug 'OmniSharp/omnisharp-vim'

  " Better Highlighting with `ctags`
  Plug 'KeitaNakamura/highlighter.nvim', { 'do': ':UpdateRemotePlugins' }

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

let g:OmniSharp_server_path = '/home/bfalk/omnisharp.http-linux-x64/omnisharp/OmniSharp.exe'
let g:OmniSharp_server_use_mono = 1

augroup omnisharp_commands
  autocmd!

  " Synchronous build (blocks Vim)
  "autocmd FileType cs nnoremap <buffer> <F5> :wa!<CR>:OmniSharpBuild<CR>
  " Builds can also run asynchronously with vim-dispatch installed
  "autocmd FileType cs nnoremap <buffer> <Leader>b :wa!<CR>:OmniSharpBuildAsync<CR>
  " Automatic syntax check on events (TextChanged requires Vim 7.4)
  "autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

  " Automatically add new cs files to the nearest project on save
  autocmd BufWritePost *.cs call OmniSharp#AddToProject()

  " Show type information automatically when the cursor stops moving
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

  " Finds members in the current buffer
  autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

  " Cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <buffer> <Leader>x  :OmniSharpFixIssue<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
  autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>

  " Navigate up and down by method/property/field
  "autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
  "autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme jellybeans
let g:airline_theme='molokai'

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

" Automatically format Elixir Files
let g:mix_format_on_save = 1


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

" I really like following the 80 columns rule with markdown
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown setlocal textwidth=80

" Pressing ,S will toggle and untoggle spell checking
map <leader>S :setlocal spell!<cr>

" Toggle wordwrap on and off
map <leader>w :setlocal wrap!<cr>

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
