" VIM GENERAL CUSTOM COMMANDS --------------------

" PATHOGEN load bundles
execute pathogen#infect()

" Delete all trailing whitespace
command! Dw :%s/\s\+$//

" Save/resotore vim session
map <F2> :mksession! ~/.vim_session <cr> " Quick write session with F2
map <F3> :source ~/.vim_session <cr>     " And load session with F3

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" ------------------------------------------------


" VIM ENVIRONMENT --------------------------------

" Colors
colorscheme molokai
syntax on

" Powerline settings
"let g:Powerline_symbols = 'fancy'
"set guifont=Sauce+Code+Powerline+Regular
set laststatus=2

" Set tab and indent settings
set tabstop=4
filetype plugin indent on

" Show line number by default
set number
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=yellow
hi PmenuSel cterm=NONE ctermfg=black ctermbg=yellow


" NAVIGATION 
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-k> :tabnew<CR>
map <C-j> :tabclose<CR>
map <C-i> :NERDTreeToggle<CR>
map <C-n> :execute "tabmove" tabpagenr() - 2 <CR>
map <C-m> :execute "tabmove" tabpagenr() <CR>

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
noremap <silent><C-g> :FufDir<CR>
noremap <silent><C-b> :FufBuffer<CR>

" NERDTree stuff
" Close tree on open...
let NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 60
