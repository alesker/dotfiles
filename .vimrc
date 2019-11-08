" General " {{{

set shell=/bin/sh

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

set formatoptions+=o    " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions-=r    " Do not automatically insert a comment leader after an enter
set formatoptions-=t    " Do no auto-wrap text using textwidth (does not apply to comments)

filetype plugin indent on   " Detect filetypes

" Trailing whitespace removal
function! RemoveTrailingWhitespaces()
    let l:save_cursor = getpos(".")
    silent! execute ':%s/\s\+$//e'
    call setpos('.', l:save_cursor)
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespaces()
" }}}

" Search " {{{
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " search is case insensitive...
set smartcase   " ... unless it has uppercase at least one capital letter
" Stop the highlighting by hitting return
nnoremap <silent> <CR> :let @/ = ""<CR>
" }}}

" UI " {{{
set showcmd         " Display incomplete commands
set showmatch       " Briefly jump to the matching bracket when a new one is inserted
set laststatus=2    " Always show status line
set scrolloff=4     " Keep cursor 4 lines the top and bottom when scrolling
set wildmenu        " Show command completion
set pumheight=16

set foldenable          " Turn on folding
set foldmethod=syntax   " Fold on the marker
set foldlevel=42        " Don't autofold

set mouseshape=n:arrow
set mouseshape=v:arrow
set mouseshape=i:beam

colorscheme desert  " Backup color scheme

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
Plugin 'fholgado/minibufexpl.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'flazz/vim-colorschemes'

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

" Color scheme
colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'

" NerdTree and MiniBufExpl
map - :call ToggleFileUI()<CR>
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! ToggleFileUI()
    :MBEOpen
    :NERDTreeToggle
endfunction

" Lightline
set noshowmode

" }}}

" hjkl mode " {{{
function! ToggleHJKLMode ()
    let w:hjkl_mode = exists('w:hjkl_mode') ? !w:hjkl_mode : 1

    if w:hjkl_mode
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
        echo 'Training wheels are on (hjkl mode off)'
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

au BufNewFile,BufRead *Appfile set ft=ruby
au BufNewFile,BufRead *Deliverfile set ft=ruby
au BufNewFile,BufRead *Fastfile set ft=ruby
au BufNewFile,BufRead *Gymfile set ft=ruby
au BufNewFile,BufRead *Matchfile set ft=ruby
au BufNewFile,BufRead *Snapfile set ft=ruby
au BufNewFile,BufRead *Scanfile set ft=ruby
au BufNewFile,BufRead *Podfile set ft=ruby
au BufNewFile,BufRead *Dangerfile set ft=ruby
au BufNewFile,BufRead *Jenkinsfile set ft=groovy


