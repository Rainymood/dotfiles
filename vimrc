


"=============================================================================="
"                   __                 __  ___                                 "
"                  / /____ _ ____     /  |/  /___   ____   ____   ___          "
"             __  / // __ `// __ \   / /|_/ // _ \ / __ \ / __ \ / _ \         "
"            / /_/ // /_/ // / / /  / /  / //  __// /_/ // /_/ //  __/         "
"            \____/ \__,_//_/ /_/  /_/  /_/ \___// .___// .___/ \___/          "
"                _   __ (_)____ ___   _____ ____/_/    /_/                     "
"               | | / // // __ `__ \ / ___// ___/                              "
"             _ | |/ // // / / / / // /   / /__                                "
"            (_)|___//_//_/ /_/ /_//_/    \___/                                "
"                                                                              "
"=============================================================================="
                                                                               
let mapleader = ","     " Remap <Leader> to ,
set nocompatible
filetype indent plugin on
syntax on

set hidden
set wildmenu            " Better CLI autocompletion
set showcmd             " Show partial commands in the last line of the screen
set hlsearch            " Highlight searches 
set ignorecase          " Case insensitive, except when using capitals
set smartcase           " See above 
set splitbelow          " Split below instead of top
set splitright          " Split right instead of left 
set backspace=indent,eol,start  " Allow backspacing over ...            (???)
set autoindent          " Set autoindent 
set nostartofline       " Stops certain movements from ...              (???)
set ruler               " Display cursor position in statusline
set laststatus=2        " Always display statusline
set confirm             " Ask if want to save changed files
set visualbell          " Set visual bell instead of error 
set t_vb=               " I have no idea what this does                 (???)
set mouse=a             " Enable mouse in all modes 
set cmdheight=2         " Gets rid of all the press enter to continue
set number              " Displays line numbers on the left
set notimeout ttimeout ttimeoutlen=200 " Quickly time out on keycodes, but ... 

set tabstop=4           " Tabs for indentation
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

set nobackup            " Disable backup and swap files 
set nowritebackup
set noswapfile

vnoremap < <gv          
vnoremap > >gv

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$


" Remap <Leader>a to align environment
" 10/2/2015 20:55 very strange all select bug leader a .... "
map <Leader>a <f5>8<CR>kj<C-l>i<Tab>

" Remap <Leader>f to frac <F7> to expand to frac
map <Leader>f ifrac<F7>

" Remap <C-T> write and compile tex
map <C-t> :w<CR><leader>ll

" Remap <Leader>v to edit .vimrc
" Changed to vsp recently 
map <Leader>v :vsp $MYVIMRC<CR><C-W>

" Remap kj to escape 
:imap kj <Esc>

" Set colorscheme to molokai
"colorscheme molokai
colorscheme badwolf

"" Pathogen
execute pathogen#infect()

" Remap spacebar for folding
nnoremap <space> za
vnoremap <space> zf

"" Use augroup to auto save folds, this speeds it up significantly
augroup Group1
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview 
    "" Automatically reload .vimrc when saved
augroup END



"" Quicksave
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C_C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>
noremap <Leader>z :update<CR>

"" Quickquit
noremap <Leader>e :quit<CR> 
noremap <Leader>E :qa!<CR>

"" Enable cursorline <Leader>c to toggle highlighting
":hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred
":hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"" Remap cntrl + n to open Nerdtree
map <C-n> :NERDTreeToggle<CR>

"" Show different background for col >80 
let &colorcolumn=join(range(81,999),",")

" Map <C-L> (redraw screen) to also turn off search highlighting until the
nnoremap <Leader><C-L> :nohl<CR><C-L>


"     _    __                ____                        
"    | |  / /_  ______  ____/ / /__  
"    | | / / / / / __ \/ __  / / _ \
"    | |/ / /_/ / / / / /_/ / /  __/
"    |___/\__,_/_/ /_/\__,_/_/\___/ 
"                                   

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'          " Let Vundle manage Vundle, required
Plugin 'tpope/vim-fugitive'         " Plugin on github repo
Plugin 'L9'

" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" see :h vundle for more details or wiki for FAQ



" Auto complete parentheses
inoremap ( ()<Esc>:call BC_AddChar(")")<CR>i
inoremap % %%<Esc>:call BC_AddChar("%")<CR>i
"inoremap < <><Esc>:call BC_AddChar(">")<CR>i
inoremap { {}<Esc>:call BC_AddChar("}")<CR>i
inoremap [ []<Esc>:call BC_AddChar("]")<CR>i
inoremap $ $$<Esc>:call BC_AddChar("$")<CR>i

inoremap <C-j> <Esc>:call search(BC_GetChar(),"W")<CR>a

function! BC_AddChar(schar)
 if exists("b:robstack")
  let b:robstack = b:robstack . a:schar
   else
    let b:robstack = a:schar
     endif
     endfunction

     function! BC_GetChar()
      let l:char = b:robstack[strlen(b:robstack)-1]
       let b:robstack = strpart(b:robstack, 0, strlen(b:robstack)-1)
        return l:char
        endfunction



""autocmd bufwritepost .vimrc source $MYVIMRC "auto source vimrc
au BufWritePost .vimrc so ~/.vimrc

"" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"" Autocomplete
"imap <Tab> <C-P>

