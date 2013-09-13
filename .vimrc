set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdtree'
Bundle 'nablaa/vim-rainbow-parenthesis'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Rykka/colorv.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sickill/vim-sunburst'
Bundle 'sickill/vim-monokai'
Bundle 'gregsexton/MatchTag'
Bundle 'sjl/gundo.vim'
Bundle 'sjl/threesome.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/vimproc'
Bundle 'eagletmt/ghcmod-vim'
Bundle 'ujihisa/neco-ghc'
Bundle 'Shougo/neocomplcache'
Bundle 'ehamberg/haskellmode-vim'
Bundle 'Twinside/vim-haskellFold'
Bundle 'Twinside/vim-hoogle'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimshell'
Bundle 'kien/ctrlp.vim'
Bundle 'ivanov/vim-ipython'
Bundle 'bitc/lushtags'
Bundle 'jimenezrick/vimerl'
Bundle 'nanotech/jellybeans.vim'
Bundle 'dag/vim2hs'
Bundle 'adinapoli/cumino'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'mfukar/robotframework-vim'
Bundle 'goldfeld/vim-seek'
Bundle 'airblade/vim-gitgutter'
Bundle 'hsitz/VimOrganizer'
Bundle 'mattn/calendar-vim'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'kovisoft/slimv'
Bundle 'hsanson/vim-android'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-fireplace'
Bundle 'davidhalter/jedi-vim'
" vim-scripts repos
Bundle 'vimwiki'
Bundle 'inkpot'
Bundle 'Wombat'
Bundle 'wombat256.vim'
Bundle 'Arduino-syntax-file'
Bundle 'a.vim'
Bundle 'haskell.vim'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'



filetype plugin indent on

" Enable mouse
set mouse=a
set tabpagemax=50

syntax on

" Indent automatically depending on filetype
filetype indent on
filetype plugin on
set autoindent

set wildmenu
set linebreak
set showcmd
set incsearch

set history=1000

" Set region to American English
set spelllang=en_us

" Case insensitive search
set ic

" Highlight search
set hls

set background=dark
set t_Co=256
colorscheme inkpot

" No wrap
set textwidth=0
set fo-=t

" Use par program
set formatprg=par\ -w79

set showmode

" Statusline
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%1*%{fugitive#statusline()}%*  " git status
set statusline+=[%{(&fenc==\"\"?&enc:&fenc)} " encoding
set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}] " BOM
set statusline+=[%{&fo}]                  " formatting options
set statusline+=[%{&tw}]                  " textwidth
set statusline+=[%{&ff}]                  " fileformat
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"set statusline+=[ASCII=\%03.3b][HEX=\%02.2B]
set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10((%l,%v/%L)%)\         " line and column
set statusline+=%P                        " percentage of file

set pastetoggle=<F2>

" disable ex mode
nmap Q q

" map ö and Ö to :
exe "nmap <Char-246> :"
exe "nmap <Char-214> :"

ino jj <esc>
cno jj <c-c>

" save file with root permissions by typing w!!
cmap w!! w !sudo tee % > /dev/null

" Buffer manipulation with UP ARROW and DOWN ARROW
nmap <special> <C-Up> :bprevious<CR>
nmap <special> <C-Down> :bnext<CR>

" C-N toggle line numbers, C-M toggle invisible symbols
nmap <silent><C-N><C-N> :set invnumber <CR>
nmap <silent><C-M><C-M> :set invlist <CR>

" Switch tabs with ALT+LEFT/RIGHT
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>

" Move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let maplocalleader='\'

" Open with current directory
let mapleader=','
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

nmap <silent> <leader>l :set list!<CR>
nmap <silent> <leader>w :set wrap!<CR>
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> <leader>n :silent :nohlsearch<CR>
nmap <silent> <leader>cd :cd %:p:h<CR>:pwd<CR>
nmap <silent> <leader>f :NERDTreeToggle<CR>
nmap <silent> <leader>a :A<CR>

" Hilight matching parenthesis
hi MatchParen cterm=NONE ctermbg=red ctermfg=black

" FileType settings

au FileType text setl tw=78
au FileType text setl fo+=t

au FileType lua setl tabstop=2
au FileType lua setl shiftwidth=2
au FileType lua setl softtabstop=2
au FileType lua setl expandtab

au FileType html,vim,javascript setl shiftwidth=4
au FileType html,vim,javascript setl tabstop=4
au FileType html,vim,javascript setl softtabstop=4

au FileType python setl shiftwidth=4
au FileType python setl tabstop=4
au FileType python setl softtabstop=4
au FileType python setl expandtab

au FileType java setl shiftwidth=4
au FileType java setl tabstop=4
au FileType java setl softtabstop=4
au FileType java setl expandtab

au FileType haskell setl shiftwidth=8
au FileType haskell setl tabstop=8
au FileType haskell setl softtabstop=8
au FileType haskell setl expandtab

au BufNewFile,BufRead *.xsd	setf xsd
au BufNewFile,BufRead *.xsl	setf xsl
au BufNewFile,BufRead *.dtd	setf dtd
au FileType xml setl tabstop=4
au FileType xml setl textwidth=0
au FileType xml setl softtabstop=4
au FileType xml setl shiftwidth=4
au FileType xml setl expandtab
au FileType xsd setl tabstop=2
au FileType xsd setl textwidth=0
au FileType dtd setl tabstop=2
au FileType dtd setl textwidth=0
au FileType xslt setl tabstop=2
au FileType xslt setl textwidth=0

au BufNewFile,BufRead *.pde setlocal ft=arduino
au BufNewFile,BufRead *.ino setlocal ft=arduino

" Color trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Whitespace chars
set listchars=eol:$,tab:>-,trail:-,extends:>,precedes:<

" Rainbow parenthesis for LISP
let g:lisp_rainbow = 1
let g:slimv_repl_syntax = 1
let g:slimv_swank_clojure = '! xterm -e lein ritz 4005 &'

" vim-latex
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" vim-commentary
" Use // instead of /* */ commenting in C and C++ files
autocmd FileType c set commentstring=//\ %s
autocmd FileType cpp set commentstring=//\ %s

" vim-easymotion
let g:EasyMotion_leader_key = '<Leader>m'

" Gundo
nnoremap <F10> :GundoToggle<CR>

" LaTeX conceal
set cole=2
let g:tex_conceal= 'adgm'
hi Conceal ctermbg=Black ctermfg=White

" Persistent undo
set undofile
set undodir=/tmp

" F3 and F4 Toggle column boundary
hi ColorColumn ctermbg=darkyellow
nmap <F4> :set colorcolumn=80,120 <CR>
nmap <F3> :set colorcolumn=0 <CR>

" Toggle Relative line numbers
nmap <F7> :set relativenumber <CR>
nmap <F6> :set norelativenumber <CR>

" TagBar
nmap <F8> :TagbarToggle <CR>

" Ghc-mod overlay color
hi ghcmodType ctermbg=yellow
let g:ghcmod_type_highlight = 'ghcmodType'

" neocomplcache plugin startup
let g:neocomplcache_enable_at_startup = 1

" haskellmode
" Use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
let g:haddock_browser = "firefox"

au BufNewFile,BufRead Tupfile,*.tup set filetype=tup

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Fix sign column background color
highlight clear SignColumn

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org            call org#SetOrgFileType()