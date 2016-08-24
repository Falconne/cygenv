set nocompatible              " be iMproved, required
filetype off                  " required
let g:zenburn_old_Visual = 1  " More visible visual
let g:yankring_replace_n_pkey = '<C-F11>'
let g:ctrlp_map = '<S-F2>'

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin("~/vimfiles/bundle")

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'

"Plugin 'scrooloose/nerdtree'

Plugin 'Zenburn'
" Colour scheme is read by other plugins so must be loaded now
colorscheme Zenburn

"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'mbbill/undotree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'myusuf3/numbers.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'PProvost/vim-ps1'
Plugin 'kshenoy/vim-signature'
Plugin 'godlygeek/tabular'
"Plugin 'haya14busa/incsearch.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set number
set laststatus=2
nmap <F3> :NumbersToggle<CR>
let g:enable_numbers = 0

nmap <F2> :CtrlPMRU<CR>
nmap <C-F2> :CtrlPBuffer<CR>

" Navigate bookmarks in file with Alt-Ctrl-Arrows
nmap <C-M-Up> ['
nmap <C-M-Down> ]'

" Navigate change hunks in file with Ctrl-Arrows
nmap <C-Up> [c
nmap <C-Down> ]c

" Surround visual selection with brackets without inner space
" (plugin)
vmap { S}
vmap ( S)
vmap [ S]

" Highlight all matches in incremental search (plugin)
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)

" Expand section by scope
map + <Plug>(expand_region_expand)
" Shrink section by scope
map _ <Plug>(expand_region_shrink)

"(Un)comment line and move down
nmap <F5> <Plug>NERDCommenterComment<Down>
nmap <S-F5> <Plug>NERDCommenterUncomment<Down>
vmap <F5> <Plug>NERDCommenterComment<Down>
vmap <S-F5> <Plug>NERDCommenterUncomment<Down>

" Enable plugin
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound

let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"'}

" Show YankRing
nmap <silent> <F11> :YRShow<CR>

" Disable gitgutter realtime monitoring
let g:gitgutter_realtime = 0

set noswapfile
set gfn=Anonymous_Pro:h16:cANSI

autocmd BufRead     *.mak      set noexpandtab
autocmd BufRead     *.bat      set nosi

autocmd BufRead     *.xml      set iskeyword+=.
autocmd BufRead     *.xml      set iskeyword+=-

autocmd BufRead     *.targets  set iskeyword+=.
autocmd BufRead     *.targets  set iskeyword+=-
autocmd BufRead     *.targets  set filetype=xml

autocmd BufRead     *.bsh      set syn=java
autocmd BufRead     *.groovy   set syn=java

autocmd BufRead     *.ps*      set iskeyword+=-
autocmd BufRead     *.ps*      set nocin

autocmd BufRead     *.build    set shiftwidth=2
autocmd BufRead     *.build    set tabstop=2
autocmd BufRead     *.build    set iskeyword+=.
autocmd BufRead     *.build    set iskeyword+=-

" Marker at column 120
set colorcolumn=120

set nobackup
set ic
syntax on
filetype on

set lcs=tab:\>\-,trail:_
set list                          " Show trailing whitespace

" Indentation
set expandtab                     " use spaces not tabs
set smarttab
set si
set ai
set cink=0{,*},e
set tabstop=4                     " number of spaces for a <Tab>
set shiftwidth=4                  " autoindent spaces
set backspace=indent,eol,start

" Split line at cursor
nmap <C-k> i<CR><Esc>

set guioptions+=a                 " autoselect (basically make copy/paste work)
set ru                            " show cursor position below each window

" Duplicate line
nmap <C-j> yyp
nmap <Esc><Esc> :noh<CR>

set nostartofline                 " on ctrl-d/u/b/d,H,G,M,L do not move
                                  " to beggining of line

set mps=(:),{:},[:]               " for % pair matching
set showmatch                     " Show matching brace with cursor
set mat=5

set hls                           " highlight all matches for the current
set keymodel=startsel,stopsel
set selection=inclusive
behave mswin

set wc=^I                         " wildcard is tab (commandline expansion)"
set wmnu                          " use a menu for tab completion"
set wildmode=longest,full

set incsearch
"Add ; to end of line
nmap ; A;<Esc>
"Add , to end of line
nmap , A,<Esc>
"<Ctrl-s> to Save
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
"<Ctrl-q> to Quit
nmap <C-q> :q<CR>

"<Alt-l> Reload file
nmap <M-l> :e!<CR>

"Auto save a file before running a command
set autowrite

"Make . work on a visually selected block
vnoremap . :normal .<CR>
set virtualedit=block

"Changes working directory on entry to each buffer
autocmd BufEnter * :cd %:p:h

" Transposing lines
nmap <M-Down> :<C-u>move .+1<CR>
nmap <M-Up> :<C-u>move .-2<CR>
imap <M-Down> <C-o>:<C-u>move .+1<CR>
imap <M-Up> <C-o>:<C-u>move .-2<CR>
vmap <M-Down> :move '>+1<CR>gv
vmap <M-Up> :move '<-2<CR>gv

"Space above/below
nmap <M-Right> O<Esc>j
nmap <M-Left> kdd
imap <M-Right> <Esc>mzO<Esc>`za
imap <M-Left> <Esc>mzkdd`za

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

nmap <space> i_<esc>r
nmap <Tab> >>
nmap <S-Tab> <<

set showbreak=...
hi NonText guifg=#efefef guibg=#4f4f4f


" Enhanced Tab functionality - Completes word if in middle of one,
" otherwise adds indent
function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
          return "\<tab>"
      else
          return "\<C-n>"
      endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

map <C-e> :Explore<CR>

set history=999
nmap U :UndotreeToggle<CR>

" Open Git Extensions commit dialog
nmap <F10> :!start /b cmd /c "C:\Program Files (x86)\GitExtensions\GitExtensions.exe" commit %:p:h<CR>

" Select word under cursor
nmap W bvw

" Paste and format
nmap <c-p> P=`]

" Search and replace for word under cursor
nmap <F4> :%s/<C-r><C-w>//gc<Left><Left><Left>
