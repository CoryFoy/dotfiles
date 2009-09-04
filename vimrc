"Set leader key
let mapleader = ","
filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
 
" Add recently accessed projects menu (project plugin)
set viminfo^=!
 
" Ignore extension files
set wildignore=*.dll,*.o,*.obj,*.bak,*.pyc,*.swp " ignore these"

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Tema
colorscheme railscasts
 
" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>
 
" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
 
syntax enable
set smartindent

set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set expandtab


" NERDTree
"
let NERDTreeShowBookmarks  = 1
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
map <leader>n :NERDTreeToggle <cr>

" FuzzyFinderTextMate
let g:fuzzy_ignore = "*.log"
let g:fuzzy_matching_limit = 70
map <leader>t :FuzzyFinderTextMate <cr>
"Search in Opened Buffers
map <leader>b :FuzzyFinderBuffer<CR> 

" TagList
map <leader>tl :TlistToggle <cr>
let Tlist_Use_Right_Window = 1

" Specky
let g:speckyQuoteSwitcherKey = "<C-S>'"
let g:speckyRunRdocKey = "<C-S>r"
let g:speckySpecSwitcherKey = "<C-S>x"
let g:speckyRunSpecKey = "<C-S>s"
let g:speckyRunSpecCmd = "spec -fs"
let g:speckyRunRdocCmd = "fri -L -f plain"
"let g:speckyVertSplit = 1
"

"Línea de cursor
set cursorline

set number
set hlsearch

"Adding #{} to AutoClose Plugin and activating it for String interpolation
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'} 
let g:AutoCloseProtectedRegions = ["Character"] 


"Load custom configuration
let my_home = expand("$HOME/")
if filereadable(my_home . '.vimrc.local')
	source ~/.vimrc.local
endif

" Quick jumping between splits
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" Refresh FuzzyFinder
map <F5> :ruby @finder = nil<cr>

" Autoindentación
if has("autocmd")
  filetype indent on
endif

" Comments
noremap <silent> ,c :s/^/#<cr> 
noremap <silent> ,u :s/^#/<cr> 

" Cheat!
command! -complete=file -nargs=+ Cheat call Cheat(<q-args>)
function! Cheat(command)
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	execute 'silent $read !cheat '.escape(a:command,'%#')
	setlocal nomodifiable
	1
endfunction

function RubyEndToken ()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
    let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
    let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'

    if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
    elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
    elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
    else
        return "\<CR>"
    endif
endfunction

function UseRubyIndent ()
    setlocal tabstop=8
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal expandtab

    imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
endfunction

autocmd FileType ruby,eruby call UseRubyIndent()

