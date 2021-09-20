call plug#begin()
  " Language Server Workhorse
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Move back and forth from tmux panes and vim panes
  Plug 'christoomey/vim-tmux-navigator'

  " A better visual status line
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Filebar on the side with git status of changes
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Better Syntax Highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " I want to see the universe
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  " And what the city to pay for it all
  Plug 'fannheyward/telescope-coc.nvim'

  " And I want it to be blinding fast
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

  " Tricked out vim icons
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " One Language Highlighter to rule them all
  Plug 'sheerun/vim-polyglot'

  " show in the line-number gutter git line status
  Plug 'airblade/vim-gitgutter'

  " Bookmark places in source
  Plug 'MattesGroeger/vim-bookmarks'

  " Better Searching
  Plug 'mileszs/ack.vim'

  " Moving at the speed of thought
  Plug 'easymotion/vim-easymotion'

  " completes ruby and elixir statements automatically
  Plug 'tpope/vim-endwise'

  " Extra Language Linting
  Plug 'neomake/neomake'

  " Format all the code!
  Plug 'sbdchd/neoformat'
call plug#end()

syntax enable

" https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
colorscheme jellybeans

" Matches jellybeans mostly
let g:airline_theme='molokai'

" Let's see those sexy powerline fonts!
let g:airline_powerline_fonts = 1

" Need to init these so they don't blow up
let g:NERDTreeExtensionHighlightColor = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}

" Elixir is light purple
let g:NERDTreeExtensionHighlightColor['ex'] = '834F79'
let g:NERDTreeExtensionHighlightColor['exs'] = '834F79'

" CSharp is an aqua
let g:NERDTreeExtensionHighlightColor['cs'] = '3AFFDB'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['cs'] = ''

" I don't care to know what branch I'm on or what the encoding is normally
" I also have a good handle on what mode I'm in :+1:
let g:airline_section_a = ''
let g:airline_section_b = ''
let g:airline_section_y = ''

" the color is true
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Always show statusline
set laststatus=2

let mapleader = ","

" Leader y and p to work with OS clipboard
map <leader>y "+y
map <leader>p "+p

" Format my code!
map <leader>f :Neoformat<CR>

nnoremap <Leader>a :Ack!<Space>

" Muscle memory wants to press F2
map <F2> :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

" qq - get me out of here reeeee
nmap qq :q<CR>

" 'jj' in Insert mode escapes back to normal mode
inoremap jj <ESC>

" Pressing ,S will toggle and untoggle spell checking
map <leader>S :setlocal spell!<cr>

" Toggle wordwrap on and off
map <leader>w :setlocal wrap!<cr>

" Toggle folding all code that hasn't changed
map <leader>gf :GitGutterFold<cr>

" Bookmark default bindings mess with me
let g:bookmark_no_default_key_mappings = 1
map <leader>mm :BookmarkToggle<cr>
map <leader>ma :BookmarkShowAll<cr>

" quick way to un-highlight in normal mode
nnoremap <CR> :noh<CR><CR>

" No swaps
set nobackup
set nowritebackup
set noswapfile

" Tabs the sane way
set tabstop=2
set expandtab
set shiftwidth=2
set autoindent

" I really like following the 80 columns rule with markdown
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown setlocal textwidth=80

" Bookmarks per working dir
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

" Run a markdown request in a side-by split
" Someday I'll make this a legit tool...
" https://github.com/benfalk/req_md
map <leader>rr :vnew \| 0read !cat # \| req_md \| jq .<cr>:set filetype=json<cr>gg

" Farewell old friend, you won't be forgotten
map <C-P> :Telescope find_files<cr>
map <leader>gg :Telescope live_grep<cr>

" On saving a file lint it
autocmd! BufWritePost * Neomake

" On save of elixir file format it
autocmd! BufWritePre *.ex undojoin | Neoformat
autocmd! BufWritePre *.exs undojoin | Neoformat

" Always show line numbers please
set nu

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore=db/*seeds/\ --ignore=spec/*.yml\ --ignore=*.csv\ --ignore=tmp/

  " It says ack ... but really it's ag ;)
  let g:ackprg = 'ag --vimgrep --ignore=spec/*.yml'
endif

" Better Syntax Highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- List of parsers to ignore installing
  ignore_install = {},
  highlight = {
    -- false will disable the whole extension
    enable = true,


    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Telescope Setup
lua <<EOF
  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = "move_selection_previous",
          ["<C-j>"] = "move_selection_next",
        },
      },
    }
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('coc')
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""" Conquer of Completion Config """""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" All of the extensions I want automatically installed
let g:coc_global_extensions=[
      \ 'coc-omnisharp',
      \ 'coc-solargraph',
      \ 'coc-elixir',
      \ 'coc-rust-analyzer',
      \ ]

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :Telescope coc references<cr>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
