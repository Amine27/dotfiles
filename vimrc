set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" This code is folded. if you want to
" unfold type za on colored line to see
" the content

" Options générales ---------- {{{
set encoding=utf8
set incsearch
set nocompatible
set backspace=indent,eol,start
set autoindent
set history=50
set ruler
set showcmd
set wildmenu
set autochdir
"above command does not work with some
"plugins. try below instead 
"autocmd BufEnter * silent! lcd %:p:h
filetype plugin indent on
syntax enable
" }}}

" Python specific options --------- {{{
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
" }}}

" Some convenient mapping -----------{{{
" Map Control+s to save current buffer
nmap <C-s> :w<CR>
imap <C-s> <ESC>:w<CR>

" Map <space> and <backspace>
nnoremap <Space> <PageDown>
nnoremap <BackSpace> <PageUp>
" }}}

" Learn vim the hardway ---------- {{{
" http://learnvimscriptthehardway.stevelosh.com

" Map jk to escape
inoremap jk <esc>

let mapleader = "ê"
nnoremap <leader>v :split $MYVIMRC<cr>
nnoremap <leader>s :source $MYVIMRC<cr>

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_text
    autocmd!
    autocmd FileType text setlocal textwidth=78
augroup END
" }}}


"noremap Q gq
"nnoremap z w
"nnoremap w z
"nnoremap q a
"nnoremap a q


