set nocompatible              " be iMproved, required
let g:zenburn_old_Visual = 1  " More visible visual
let g:yankring_replace_n_pkey = '<C-F11>'
let g:ctrlp_map = '<S-F2>'

filetype plugin indent on    " required

colorscheme zenburn
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

let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"'}

" Show YankRing
nmap <silent> <F11> :YRShow<CR>

" Disable gitgutter realtime monitoring
let g:gitgutter_realtime = 0

set noswapfile

" Marker at column 120
set colorcolumn=120

set nobackup
set ic
syntax on

set lcs=tab:\>\-,trail:_
set list                          " Show trailing whitespace

" Remove trailing whitespace
nmap <M-x> :%s/\s\+$//g<CR>:noh<CR>

" Indentation
set expandtab                     " use spaces not tabs
set smarttab
set si
set ai
set cin
"set cink=0{,*},e
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
          return "\<C-p>"
      endif
endfunction

inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <C-D>

map <C-e> :Explore<CR>

set history=999
nmap U :UndotreeToggle<CR>

" Select word under cursor
nmap W bve

" Paste and format
nmap <c-p> P=`]

" Search and replace for word under cursor
nmap <F4> :%s/<C-r><C-w>//gc<Left><Left><Left>

autocmd BufEnter     *.mak      set noexpandtab


autocmd BufEnter     *.xml      set iskeyword+=.
autocmd BufEnter     *.xml      set iskeyword+=-

autocmd BufEnter     *.targets  set iskeyword+=.
autocmd BufEnter     *.targets  set iskeyword+=-
autocmd BufEnter     *.targets  set filetype=xml

autocmd BufEnter     *.*proj    set filetype=xml
autocmd BufEnter     *.*proj    set shiftwidth=2
autocmd BufEnter     *.*proj    set tabstop=2

autocmd BufEnter,BufRead     *.yaml,*.yml    set shiftwidth=2
autocmd BufEnter,BufRead     *.yaml,*.yml    set tabstop=2

autocmd BufEnter     *.ps*      set iskeyword+=-
autocmd BufEnter     *.ps*      set cindent cinoptions& cinoptions+=+0 cinkeys-=0#

" Disable comment continuation.
" Some plugin keeps resetting this, so have to do it every time.
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

:hi ColorColumn guibg=#454545

" Stop hiding quotes in json
set conceallevel=0
