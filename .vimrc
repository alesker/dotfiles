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
set wildmenu        " Show command completion
set wildmode=longest:full,full
set pumheight=16



" Scrolling and wrapping
set nowrap
set scrolloff=0
set sidescroll=1
set listchars=extends:>,precedes:<
set sidescrolloff=1

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

" Vim-Plug " {{{
" https://github.com/junegunn/vim-plug#installation

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'fholgado/minibufexpl.vim', { 'on': 'MBEOpen' }
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'

Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

Plug 'dense-analysis/ale'
"Plug 'flazz/vim-colorschemes'
call plug#end()

" }}}


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

" Startify
let g:header = [
            \ '             __                ',
            \ '     .--.--.|__|.--------.     ',
            \ '     |  |  ||  ||        |     ',
            \ '      \___/ |__||__|__|__|     ',
            \ '                               ',
            \ 'Do. Or do not. There is no try.',
            \ '                               ',
            \]
let g:footer = [
            \ '                         ',
            \ 'May the Force be with you'
            \]
let g:startify_custom_header = 'startify#center(g:header)'
let g:startify_custom_footer = 'startify#center(g:footer)'
let g:startify_padding_left = float2nr((winwidth('%') - 80) / 2)

let g:startify_bookmarks = [
            \ {'v': '~/.vimrc'},
            \ {'z': '~/.zshrc'}
            \]
let g:startify_skiplist = [
        \ '.*/.vimrc',
        \ '.*/.zshrc',
        \ 'COMMIT_EDITMSG',
        \ 'plugged/.*/doc/.*\.txt',
        \ ]
let g:startify_files_number = 5

" ALE
let g:ale_linters = {
      \   'ruby': ['rufo', 'ruby', 'solargraph'],
      \}
let g:ale_sign_error = '‼️'
let g:ale_sign_warning = '⚠️'
let g:ale_fixers = {
      \    'ruby': ['rufo'],
      \}
let g:ale_fix_on_save = 1
" }}}

" Coloring

function! CheckSystemInterfaceStyle(...)
    let g:apple_interface_style=system("defaults read -g AppleInterfaceStyle")
    if g:apple_interface_style ==? "Dark\n"
        set bg=dark
    else
        set bg=light
    endif
endfunction

if !has('gui_running')
    colorscheme gruvbox
    let g:gruvbox_contrast_dark='soft'
else
    let g:one_allow_italics = 1
    colorscheme one
    call CheckSystemInterfaceStyle()
    call timer_start(3000, "CheckSystemInterfaceStyle", {"repeat": -1})
endif

let g:lightline = {
            \ 'colorscheme': g:colors_name,
            \ }

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
