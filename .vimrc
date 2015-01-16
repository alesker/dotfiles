" General " {{{

set nocompatible

set hidden              " Current buffer can be put to background without writing to disk
set backspace=indent,eol,start
set virtualedit=all     " Allow to position cursor where there is no actual character in all modes
syntax on

nnoremap j gj
nnoremap k gk

" Formatting " {{{
set expandtab                               " use spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4    " set indent to 4

set autoindent
set nowrap

set formatoptions-=r    " Do not automatically insert a comment leader after an enter

filetype plugin indent on   " Detect filetypes

" Trailing whitespace removal
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" Search " {{{
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " search is case insensitive...
set smartcase   " ... unless it has uppercase at least one capital letter
" Stop the highlighting by hitting return
nnoremap <CR> :noh<CR><CR>
" }}}

" UI " {{{
set showcmd         " Display incomplete commands
set showmatch       " Briefly jump to the matching bracket when a new one is inserted
set laststatus=2    " Always show status line
set scrolloff=4     " Keep cursor 4 lines the top and bottom when scrolling
set wildmenu        " Show command completion

set mouseshape=n:arrow
set mouseshape=v:arrow
set mouseshape=i:beam

if has('gui_running')
    colorscheme desert
else
    colorscheme desert256
endif

set guioptions+=b
set guioptions-=T

set number

function! ToggleRelative()
    if &relativenumber
        set norelativenumber
    else
        set relativenumber
   endif
endfunction
map <Leader>r :call ToggleRelative()<CR>

" Automatically open and close the popup menu / preview window
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,longest ",menuone - menu appears even if there's only one match
" }}}

" }}}

" Plugins " {{{

" Vundle " {{{
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'msanders/snipmate.vim'
Plugin 'Valloric/YouCompleteMe'

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

" }}}


" Supertab
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = '<c-n>'

" You Complete Me
"let g:ycm_min_num_of_chars_for_completion = 1


" NerdTree
map <F2> :NERDTreeToggle <CR>
let NERDTreeShowHidden=0

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" TagList
"map <F3> :NERDTreeClose <CR> :TlistToggle <CR>
"let Tlist_Auto_Update = 1
"let Tlist_Auto_Highlight_Tag = 1
"let Tlist_Use_Horiz_Window = 0
"let Tlist_Use_Right_Window = 0


"MiniBufExplorer
"let g:miniBufExplMinHeight=1
"let g:miniBufExplorerMoreThanOne=0

" }}}

" hjkl mode " {{{
function! ToggleHJKLMode ()
   let w:true_mode = exists('w:hjkl_mode') ? !w:hjkl_mode : 1

   if w:true_mode
      echo 'Training wheels are off (hjkl mode on)'
      nnoremap <up> <nop>
      nnoremap <down> <nop>
      nnoremap <left> <nop>
      nnoremap <right> <nop>
      vnoremap <up> <nop>
      vnoremap <down> <nop>
      vnoremap <left> <nop>
      vnoremap <right> <nop>
      inoremap <up> <nop>
      inoremap <down> <nop>
      inoremap <left> <nop>
      inoremap <right> <nop>
   else
      echo 'Training wheels are off (hjkl mode on)'
      nnoremap <up> <up>
      nnoremap <down> <down>
      nnoremap <left> <left>
      nnoremap <right> <right>
      vnoremap <up> <up>
      vnoremap <down> <down>
      vnoremap <left> <left>
      vnoremap <right> <right>
      inoremap <up> <up>
      inoremap <down> <down>
      inoremap <left> <left>
      inoremap <right> <right>
   endif
endfunction
map <Leader>tm :call ToggleHJKLMode()<CR>
" }}}
