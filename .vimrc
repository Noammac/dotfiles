" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

endif " has("autocmd")

set autoindent		" always set autoindenting on
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
filetype off                  " required
set noshowmode
set laststatus=2

" LaTeX (rubber) macro for compiling - pdf
nnoremap <leader>cp  :w<CR>:!rubber --pdf --warn all %<CR>

" LaTeX (lualatex) macro for compiling
nnoremap <leader>cl :w<CR>:!lualatex %<CR>

" LaTeX (xelatex) macro for compiling
nnoremap <leader>cx :w<CR>:!xelatex %<CR>

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!mupdf %:r.pdf &<CR><CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ALE linting and completion
Plugin 'w0rp/ale'

" Minimap
Plugin 'severin-lemaignan/vim-minimap'

" Indentation guide
Plugin 'nathanaelkane/vim-indent-guides'

" Git integration
Plugin 'tpope/vim-fugitive'

" Status line
Plugin 'itchyny/lightline.vim'

" tmux status line
Plugin 'edkolev/tmuxline.vim'

" Indentation guide
let g:indent_guides_enable_on_vim_startup = 1

" lightline configuration
let g:lightline = {
		\ 'colorscheme': 'wombat',
		\ 'active': {
		\   'left': [ [ 'mode', 'paste'],
		\             [ 'fugitive', 'readonly', 'filename' ] ]
		\ },
		\ 'component': {
		\   'lineinfo': ' %3l:%-2v',
		\ },
		\ 'component_function': {
		\   'readonly': 'LightlineReadonly',
		\   'fugitive': 'LightlineFugitive',
		\   'filename': 'LightlineFilename'
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' }
		\ }
function! LightlineReadonly() abort
	return &readonly ? '' : ''
endfunction
function! LightlineFugitive() abort
	if exists('*fugitive#head')
		let branch = fugitive#head()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction
function! LightlineFilename() abort
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filename . modified
endfunction

" tmuxline configuration
let g:tmuxline_theme = 'lightline'
let g:tmuxline_preset = 'tmux'

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
