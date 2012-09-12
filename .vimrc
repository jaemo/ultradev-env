runtime plugin/source.vim
syntax on
filetype plugin indent on
set guifont="Droid Sans Mono for Powerline":h15
set guioptions-=T

"set updatetime=6000
"au CursorHoldI * stopinsert

" Determine machine (alpha.mydevbox.com, beta.mydevbox.com, something.local)
let hostname = substitute(system('hostname'), '\n', '', '')

" Comma is the leader character
let mapleader = ","

" Basic stuff
set nocompatible
set mouse=a
set hidden
set title
set visualbell
set timeoutlen=500
set scrolloff=0
set history=1000

" Status bar
set number
set ruler
set showcmd
set showmode
set laststatus=2

" Wild stuff!
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,*.pyc,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*,*.DS_STORE,*.db,*.swc,*.tar,*.tgz,.git,public_html/images/**,public_html/upload/**,var/**,*/uploads/**,*/pear/**

" Encoding
set encoding=utf-8
" set bomb

" Whitespace
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
set backspace=indent,eol,start

" Use modeline overrides
set modeline
set modelines=10

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set nobackup
set nowritebackup

" Remember last location in file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Let split windows be different sizes
set noequalalways

" Split shortcuts
nmap <leader>- :sp<CR>
nmap <leader>= :vs<CR>
nmap <leader>c :close<CR>
nmap <leader>cc :tabclose<CR>

" Smart way to move between windows. Ctrl-[h,j,k,l]
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" If in Visual Mode, resize window instead of changing focus. Ctrl-[h,j,k,l]
vmap <C-j> <C-W>+
vmap <C-k> <C-W>-
vmap <C-h> <C-W><
vmap <C-l> <C-W>>

" Let directional keys work in Insert Mode. Ctrl-[h,j,k,l]
"imap <C-j> <Esc>ja
"imap <C-k> <Esc>ka
"imap <C-h> <Esc>ha
"imap <C-l> <Esc>la

" Cursor movement in command mode
" cmap <C-j> <Down>
" cmap <C-k> <Up>
" cmap <C-h> <Left>
" cmap <C-l> <Right>
cmap <C-x> <Del>
cmap <C-z> <BS>
cmap <C-v> <C-R>"

" 0 is beginning of line, so make - the end of the line
nmap - $

" Visual shifting (builtin-repeat)
vmap <S-Tab> <gv
vmap <Tab> >gv

" Better visual block selecting
set virtualedit+=block

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Ack for the last search.
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" Clear search with comma-space
noremap <leader><space> :noh<CR>:match none<CR>:2match none<CR>:3match none<CR>

nmap <S-h> :tabprevious<CR>
nmap <S-l> :tabnext<CR>
nmap < :tabprevious<CR>
nmap > :tabnext<CR>

nmap <leader>t :tabnew<CR>
nmap ;t :tab ball<CR>
set tabpagemax=50

" Toggle between modes with <Ctrl-q>
nnoremap <C-q> :
cnoremap <C-q> <Esc>
inoremap <C-q> <Esc>
vnoremap <C-q> <Esc>

" F5 will remove trailing whitespace and tabs
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Redraw shortcut
noremap <C-m> <Esc>:redraw!<CR>

" Opens an edit command with the path of the currently edited file filled in
map :ee :e <C-R>=expand("%:p:h") . "/" <CR>

" ;cd to current file
nnoremap ;cd :cd %:p:h<CR>:pwd<CR>

" Alt-tab between buffers
nnoremap <leader><leader> <c-^>
nmap <leader>6 <C-^>
nmap <leader>^ <C-^>
map <M-tab>: <C-^>

" When pasting from OS's clipboard, hit ,P command-v ,P
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p

" Use OS X clipboard
set clipboard=unnamed

" Make 'Y' follow 'D' and 'C' conventions'
nnoremap Y y$

" u is undo, so make shift-u redo (don't need 'undo line' anyway...)
nmap <S-u> <C-R>

" sudo & write if you forget to sudo first
cmap w!! w !sudo tee % >/dev/null

" Launch vimrc with ,v
nmap <leader>v :EditVimRC<CR>
command! EditVimRC call s:EditVimRC()
function! s:EditVimRC()
  let l:title = expand("%:t")
  if (l:title == '.vimrc')
    :edit ~/.gvimrc
  else
    :edit ~/.vimrc
  endif
endfunction

"============="

command! SearchFile let q = input("Search within this file: ") | exe "/".q."/"

command! SearchReplace let q = input("Search within this file: ") | let r = input("...and replace with this: ") | exe ":%s/".q."/".r."/g"
nmap <leader>r :SearchReplace<CR>

command! SearchReplaceLast let r = input("Replace last search with this: ") | exe ":%s//".r."/g"
nmap <leader>rr :SearchReplaceLast<CR>

if executable("ack")
  command! SearchProject let q = input("Search within this project: ") | exe ":Ack -a ".q
endif

"============="

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<CR>

" Move to the next misspelled word
map <leader>sn ]s

" Move to the previous misspelled word
map <leader>sp [s

" Add word to dictionary
map <leader>sa zg

" View spelling suggestions for misspelled word
map <leader>s? z=

"============="

Source https://github.com/mileszs/ack.vim

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
  nnoremap <leader>a :Ack -a ""<left>
  cabbrev ack Ack -a ""<left>
endif

"============="

Source https://github.com/vim-scripts/bufexplorer.zip

command! Buffers call s:Buffers()
function! s:Buffers()
  let l:title = expand("%:t")
  if (l:title == '[BufExplorer]')
    :b#
  else
    :silent BufExplorer
  endif
endfunction

nmap <S-k> :Buffers<CR>

"============="
set t_Co=256

Source https://github.com/vim-scripts/ScrollColors
nmap ;cc :COLORSCROLL<CR>

"Source https://github.com/bzx/vim-theme-pack

Source https://github.com/altercation/vim-colors-solarized
"let g:solarized_contrast="high"
"call togglebg#map(";b")
let g:solarized_termtrans = 1
colorscheme railscasts

"set background=dark
"nmap ;c :colorscheme 

"============="

" CtrlP
Source https://github.com/kien/ctrlp.vim

let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }
imap <C-g> <ESC>:CtrlP .<CR>
vmap <C-g> <ESC>:CtrlP .<CR>
nmap <C-g> <ESC>:CtrlP .<CR>

"============="

Source https://github.com/mattn/gist-vim

let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

"============="

Source https://github.com/roman/golden-ratio

let g:golden_ratio_autocommand = 0
nmap ;r :GoldenRatioToggle<CR>

"============="

Source https://github.com/sjl/gundo.vim

" ,u will show undo history graph
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_right = 1

"============="

Source https://github.com/rgarver/Kwbd.vim

" :bd deletes a buffer, :BD deletes a buffer and keeps its window
command! BD Kwbd

" Don't save, close buffer, keep window
nmap ZX :BD<CR>

" Don't save, close buffer, close window
nmap ZXX :bd!<CR>

" Save, close buffer, keep window
nmap ZSX :w<CR>:BD<CR>

" Save, close buffer, close window
nmap ZSXX :w<CR>:bd!<CR>

" Save the buffer
nmap ZS :w<CR>
nmap <leader>w :w<CR>

"============="

runtime! macros/matchit.vim
nmap <Space> %

"============="

Source https://github.com/Lokaltog/vim-easymotion

let g:EasyMotion_leader_key = ';m'

" <leader>m to easy-motion entire screen. If cancelling,
" double tap `` to go back to previous cursor position
nmap <leader>m m`:normal! H<cr>;mw


"============="

Source https://github.com/vim-scripts/jade.vim
Source https://github.com/vim-scripts/jQuery
Source https://github.com/tpope/vim-haml
Source https://github.com/pangloss/vim-javascript
Source https://github.com/tpope/vim-markdown

" special filetype syntax coloring
""au Bufread,BufNewFile {ssh-config} set ft=sshconfig
""au Bufread,BufNewFile {.rvmrc,rvmrc} set ft=sh
""au Bufread,BufNewFile {.gitconfig,gitconfig} set ft=gitconfig
""au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Capfile,config.ru} set ft=ruby
""au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set wrap | set wrapmargin=2 | set textwidth=72


Source https://github.com/kchmck/vim-coffee-script
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

nmap _js :setfiletype javascript<CR>
nmap _rb :setfiletype ruby<CR>
nmap _vi :setfiletype vim<CR>
nmap _ph :setfiletype php<CR>
nmap _sh :setfiletype sh<CR>
nmap _cs :setfiletype css<CR>
nmap _co :setfiletype coffee<CR>
nmap _sm :setfiletype smarty<CR>
nmap _md :setfiletype markdown<CR>
nmap _hm :setfiletype haml<CR>

"============="

Source https://github.com/tpope/vim-unimpaired

" Bubble multiple lines
vmap _ [egv
vmap + ]egv

"============="

Source https://github.com/vim-scripts/YankRing.vim

nnoremap <silent> [p :YRShow<cr>
inoremap <silent> [p <ESC>:YRShow<cr>
let g:yankring_history_file = '.yankring_history'
let g:yankring_min_element_length = 2
let g:yankring_manual_clipboard_check = 1

"============="

Source https://github.com/vim-scripts/ZoomWin

map <Leader>z :ZoomWin<CR>

"============="



"============="

Source https://github.com/tpope/vim-rails
Source https://github.com/tsaleh/vim-shoulda
"Source https://github.com/tpope/vim-rvm

" Fancy rails/tmux tdd goodness
Source https://github.com/kikijump/tslime.vim
Source https://github.com/jgdavey/vim-turbux

"============="

" Auto-close parenthesis and quotes
"Source https://github.com/kana/vim-smartinput
"Source https://github.com/Raimondi/delimitMate
"Source https://github.com/jiangmiao/auto-pairs

"============="

Source https://github.com/tpope/vim-endwise
Source https://github.com/msanders/snipmate.vim
Source https://github.com/tomtom/tcomment_vim
Source https://github.com/ervandew/supertab
Source https://github.com/tpope/vim-fugitive
Source https://github.com/tpope/vim-git
"Source https://github.com/tpope/vim-surround
Source https://github.com/tpope/vim-unimpaired
Source https://github.com/tpope/vim-repeat
Source https://github.com/tsaleh/vim-align
Source https://github.com/vim-scripts/camelcasemotion
Source https://github.com/vim-scripts/IndexedSearch
Source https://github.com/airblade/vim-rooter
Source https://github.com/mortice/pbcopy.vim
Source https://github.com/tpope/vim-bundler
Source https://github.com/guns/xterm-color-table.vim
Source https://github.com/sjl/vitality.vim.git


"============="

Source https://github.com/scrooloose/nerdtree

" NERDTree toggles with ,d
map <Leader>d :NERDTreeToggle \| :silent NERDTreeMirror<CR>
map <Leader>dd :NERDTreeFind<CR>
let NERDTreeIgnore=['\.rbc$', '\~$','\.DS_Store$','\.git$']
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1

"======="

" STATUS BAR
Source https://github.com/Lokaltog/vim-powerline
let g:Powerline_symbols = 'fancy'



function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" disable arrow keys
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>



autocmd BufEnter * :syntax sync fromstart

"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10

if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;orange\x7"
    " use a red cursor otherwise
    let &t_EI = "\<Esc>]12;red\x7"
    "silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
    "autocmd VimLeave * silent !echo -ne "\033]112\007"
    " use \003]12;gray\007 for gnome-terminal
endif


if &term =~ '^xterm'
    " solid underscore
    let &t_SI .= "\<Esc>[4 q"
    " solid block
    let &t_EI .= "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
endif



" Enable CursorLine
set cursorline

" Default Colors for CursorLine
highlight  CursorLine ctermbg=13 ctermfg=None

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=None

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=13 ctermfg=None
