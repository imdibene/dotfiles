" GENERAL ---------------------------------------------------------------- {{{
"
set runtimepath^=$XDG_CONFIG_HOME/vim

" Colorscheme
colorscheme desert

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" encoding
set encoding=utf-8

" Add numbers to the file.
set number
" Numbers are relative to the selected line
set relativenumber

" Normal mode - block cursor
let &t_EI = "\e[2 q"
" Insert mode - vertical bar cursor
let &t_SI = "\e[6 q"
" Replace mode - underscore cursor
let &t_SR = "\e[4 q"

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
"set cursorcolumn

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
"set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Search down into subdirectories.
" Provides tab-completion for all file related tasks.
set path+=**
" Enable auto completion menu after pressing TAB.
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" Backspace over anything
set backspace=indent,eol,start

" Textlength visual rule
set colorcolumn=80
highlight colorcolumn ctermbg=238

" Enable mouse support
set mouse+=a

" fzf integration
set rtp+=/opt/homebrew/opt/fzf

" Highlight trailing whitespaces
highlight TrailingWhitespace ctermbg=yellow guibg=yellow
match TrailingWhitespace /\s\+$/
" }}}


"MYVIMRC PLUGINS ---------------------------------------------------------------- {{{
"call plug#begin('~/.config/vim/plugged')
"	Plug 'dense-analysis/ale'
"	Plug 'preservim/nerdtree'
"	Plug 'gregkh/kernel-coding-style'
"call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{
" Set the comma as the leader key.
let mapleader = ","

" Press ,, to jump back to the last cursor position.
nnoremap <leader>, ``

" Yank from cursor to the end of line.
nnoremap Y y$

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Try to prevent bad habits, like using the arrow keys for movement.
" ...Do this in normal mode
nnoremap <Left>		:echoe "Use 'h'"<CR>
nnoremap <Down>		:echoe "Use 'j'"<CR>
nnoremap <Up>		:echoe "Use 'k'"<CR>
nnoremap <Right>	:echoe "Use 'l'"<CR>
" ...and this in insert mode
noremap <Left>		<ESC>:echoe "Use 'h'"<CR>
noremap <Down>		<ESC>:echoe "Use 'j'"<CR>
noremap <Up>		<ESC>:echoe "Use 'k'"<CR>
noremap <Right>		<ESC>:echoe "Use 'l'"<CR>

" Check file in shellcheck --> ,s
map <leader>s :!clear && shellcheck -x %<CR>

" Spell-check set to <leader>o --> ,o 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" copy & paste vim <=> system
noremap <c-y> "+y
noremap <c-p> "+P

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
"nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
"let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

"" use nerdtree instead of netrw
" FILE BROWSING:
" Tweaks for browsing
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
"let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" SNIPPETS: TODO: setup the skeleton files, then activate the snippets mapping
" Insert an empty <LANG> template into current workspace
nnoremap <leader>zz :-1read $HOME/.config/vim/templates/zettel.md<CR> " Zettel
nnoremap <leader>cc :-1read $HOME/.config/vim/templates/class.cc<CR> " C++
"nnoremap <leader>hs :-1read $HOME/.config/vim/templates/skeleton.hs<CR>	" Haskell
"nnoremap <leader>ht :-1read $HOME/.config/vim/templates/skeleton.html<CR> " HTML
"nnoremap <leader>md :-1read $HOME/.config/vim/templates/skeleton.md<CR> " Markdown
"nnoremap <leader>ml :-1read $HOME/.config/vim/templates/skeleton.ml<CR>	" OCaml
"nnoremap <leader>pl :-1read $HOME/.config/vim/templates/skeleton.pl<CR>	" Perl
"nnoremap <leader>py :-1read $HOME/.config/vim/templates/skeleton.py<CR>	" Python
"nnoremap <leader>rk :-1read $HOME/.config/vim/templates/skeleton.rkt<CR> " Racket
"nnoremap <leader>rs :-1read $HOME/.config/vim/templates/skeleton.rs<CR>	" Rust
"nnoremap <leader>sh :-1read $HOME/.config/vim/templates/skeleton.sh<CR>	" Shell

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{
" Enable the marker method of folding.
" zo to open a single fold under the cursor.
" zc to close the fold under the cursor.
" zR to open all folds.
" zM to close all folds.
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is YAML, set indentation to 2 spaces.
autocmd Filetype yml setlocal tabstop=2 shiftwidth=2 expandtab

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If the current file type is OCaml, set indentation to 4 spaces.
autocmd Filetype ocaml setlocal tabstop=4 shiftwidth=4 expandtab

" If the current file type is Haskell, set indentation to 4 spaces.
autocmd Filetype haskell setlocal tabstop=4 shiftwidth=4 expandtab

" If the current file type is Python, set indentation to 4 spaces.
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
	set undodir=~/.config/vim/backup
	set undofile
	set undoreload=10000
endif

" TAG JUMPING:
" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" Remove trailing whitespace and newlines when file saving (except for binary
" files ended in .bi)
autocmd BufWritePre * if expand('<afile>') !~ '\.bi$' | :%s/\s\+$//e
autocmd BufWritePre * if expand('<afile>') !~ '\.bi$' | :%s/\n\+\%$//e
"autocmd BufWritePre *.[ch] :%s/\%$/\r/e " add trailing newline for ANSI C standard

" Create a jump stack for better navigation
let g:jump_stack = []

function! PushJump()
  let g:jump_stack = get(g:jump_stack, 'jump_stack', [])
  call add(g:jump_stack, [bufnr('%'), line('.'), col('.')])
  " Keep only last 100 jumps
  if len(g:jump_stack) > 100
    call remove(g:jump_stack, 0)
  endif
endfunction

function! PopJump()
  if len(g:jump_stack) > 0
    let [buf, line, col] = remove(g:jump_stack, -1)
    execute 'buffer ' . buf
    call cursor(line, col)
  else
    echo "Jump stack empty"
  endif
endfunction

" Hook into gf
nnoremap <silent> gf :call PushJump()<CR>gf
nnoremap <silent> gb :call PopJump()<CR>


" AUTOCOMPLETE:
" The good stuff is documented in |ins-completion|
" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option
" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" BUILD INTEGRATION:
" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix
" Configure the `make` command to run RSpec
set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter
" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back
" }}}


" STATUS LINE ------------------------------------------------------------ {{{
" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii/unicode:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
" }}}

" CONFIG OVERRIDE -------------------------------------------------------- {{{
" To override the env settings in a project (directory) basis
if filereadable(".vimrc_proj")
	so .vimrc_proj
endif
" }}}
