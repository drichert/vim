set nocompatible
let mapleader = "," " set mapleader to comma instead of backslash
set backspace=indent,eol,start
set hidden
set history=200     " number of lines of history to remember
set title
set ruler
set number          " line numbers
set hlsearch        " highlight searches
"set cursorline      " highlight line for cursor position (seems to make gvim
"slooow)
"set spell          " turn on spell check
set cmdheight=2     " make command lines 2 high
syntax on           " syntax highlighting
set autoread        " reload file when changed elsewhere
set tabstop=4       " number of spaces for a tab
set shiftwidth=4    " number of spaces to autoindent
set scrolloff=3     " keep 3 lines when scrolling
set mousehide       " hide pointer when typing 
set ttyfast         " smoother changes
set dictionary+=/usr/share/dict/words " set dictionary for autocomplete

set autoindent      " use idention from above line in new line
set wildmenu        " better tab completion for :commands

filetype plugin indent on " turn on plugins and indention
autocmd BufEnter * :sil! lcd %:p:h " switch to file's dir
set tags=tags;/


set ignorecase "Ignore case when searching
" smartcase, overrides 'ignorecase' when pattern has upper case characters
set scs
set incsearch

" Folding
set nofen
set fdl=0

set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

"nmap <c-s> :w<CR>
"vmap <c-s> <esc><c-s>
"imap <c-s> <esc><c-s>


"---- Options for Windows
if has("gui_running")
	set guioptions-=T " no toolbar
	set guioptions-=m " no menubar
	set guifont=Liberation\ Mono\ 8
	set lines=75          " height = 50 lines
	set columns=180       " width = 100 columns
	set background=dark   " adapt colors for background
	"set selectmode=mouse,key,cmd
	set mousehide
	"colorscheme darkspectrum
	"colorscheme tango2
	"colorscheme wombat
	colorscheme darkburn
else
	set background=dark   " adapt colors for dark background
	colorscheme darkburn  " use this color scheme
endif

" turn off hilighted search terms
map <leader>n :nohls<CR>

",v brings up my .vimrc
"",V reloads it -- making all changes active (have to save first)
map ,v :sp ~/.vimrc<CR><C-W>_
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

map <C-n> :NERDTreeToggle<CR>
map <leader>t :TlistToggle<CR>

" snipMate setup
let g:snips_author = 'Matt McKeon'

" shortcuts for sessionman
map <leader>l :SessionList<CR>
map <leader>s :SessionSave<CR>

" lets make quicker
map <leader>m :make<CR>

" quickly reformat newlines from windows editors
map <leader>w :%s/\r//g<CR>
map <leader>W :%s/\r/\r/g<CR>

let g:EnhCommentifyRespectIndent = 'Yes'

" Shortcuts for dealing with splits easier {{{
map <C-j> <C-W>j
map <C-k> <C-W>k
map <c-l> <c-w>l 
map <c-h> <c-w>h 

" use + and - to resize horizontal splits
map - <c-w>-
map + <c-w>+
" and for vsplits with alt-< or alt->
map <M-,> <C-W><
map <M-.> <C-W>>
" }}}

" mapping to make movements operate on 1 screen line in wrap mode {{{
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")
"}}}

" setup omnicompletion for file types {{{
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
imap <C-f> <C-x><C-o>
"}}}

" making tabs fun again!
noremap <silent> <c-tab> :tabn <cr>
noremap <silent> <c-s-tab> :tabp <cr>
noremap <silent> <c-t> :tabnew<cr>

" setup php-doc
source ~/.vim/plugin/php-doc.vim
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 


" Run php lint test
map <F9> :w<CR>:!php -l %<CR>
" toggle paste mode
map <F8> :set paste!<Bar>set paste?<CR>
" toggle spell checking
map <F7> :set spell!<Bar>set spell?<CR>

if !exists("mm_filetype_config")
	let mm_filetype_config = 1

	" setup actionscript filetypes
	autocmd BufNewFile,BufRead *.mxml set filetype=mxml
	autocmd BufNewFile,BufRead *.as set filetype=actionscript

	" Turn on spelling in subversion/git commits
	autocmd BufNewFile,BufRead svn-commit.* set spell
	autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

	" chage :make for different languages
	autocmd FileType php set makeprg=php\ -l\ %
	autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l
	autocmd FileType py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
	autocmd FileType py set errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
endif