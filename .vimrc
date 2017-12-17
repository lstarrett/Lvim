" VIM GENERAL CUSTOM COMMANDS --------------------
let mapleader = ","

" PATHOGEN load bundles
execute pathogen#infect()

" Delete all trailing whitespace
command! Dw :%s/\s\+$//

" Save/resotore vim session
map <F2> :mksession! ~/.vim_session <CR> " Quick write session with F2
map <F3> :source ~/.vim_session <CR>     " And load session with F3

" Search for highlighted text, or word under cursor
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" ------------------------------------------------


" VIM ENVIRONMENT --------------------------------


" Indentation
set tabstop=4 shiftwidth=4

" Colors
colorscheme molokai
syntax on

" Powerline settings
set laststatus=2

" Set tab and indent settings
" NOTE: vim-slueth plugin is in use to heuristically match
" indentation settings of current file, so don't do too much
" manually here.
filetype plugin indent on

" Create a new line from normal mode
noremap <Enter> o<ESC>

" Show line number by default
set number
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=yellow
hi PmenuSel cterm=NONE ctermfg=black ctermbg=yellow


" NAVIGATION 
map <C-l> :call MoveRight()<CR>
map <C-h> :call MoveLeft()<CR>
map <C-k> :tabnew<CR>
map <C-j> :call Close()<CR> 
map <C-i> :-tabmove <CR>
map <C-o> :+tabmove <CR>
map <C-g> :vsp<CR>

function! MoveLeft()
if winnr() == 1
tabp
else
wincmd h
endif
endfunction

function! MoveRight()
if winnr('$') == winnr()
tabn
else
wincmd l
endif
endfunction

function! Close()
if winnr('$') == 1
q
else
wincmd q
endif
endfunction

"Enable and disable mouse use
noremap <f1> :call ToggleMouse() <CR>
function! ToggleMouse()
if &mouse == 'a'
set mouse=
echo "Mouse usage disabled"
else
set mouse=a
echo "Mouse usage enabled"
endif
endfunction

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
" ------------------------------------------------


" PLUGIN MODS ------------------------------------

" FUGITIVE stuff
" Stay on same absolute line (when possible) when moving through history
"nnoremap <silent><C-[> :let line = line('.')<CR>:cn<CR>:exec ':' . line<CR>
"nnoremap <silent><C-]> :let line = line('.')<CR>:cp<CR>:exec ':' . line<CR>

" FUZZYFINDER stuff
noremap <silent><C-f> :FufFile<CR>
" noremap <silent><C-g> :FufDir<CR>
noremap <silent><C-b> :FufBuffer<CR>

" vim-latex settings
let s:latexmk = "~/.vim/latexmk/latexmk.pl -pdf -pvc"
map <C-c> :VimLatexCompileToggle<CR>
