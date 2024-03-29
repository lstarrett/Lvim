" VIM GENERAL CUSTOM COMMANDS --------------------
let mapleader = " "

" PATHOGEN load bundles
execute pathogen#infect()

" Delete all trailing whitespace
command! Dw :%s/\s\+$//

" Session options
set sessionoptions-=globals
set sessionoptions-=localoptions
set sessionoptions-=options

" Edit .vimrc
command! Vimrc :e ~/.vimrc
cnoreabbrev vimrc Vimrc
command! Sp :source ~/.vimrc
cnoreabbrev sp Sp " .vimrc sourced!

" Save vim session
command! Vims :mksession! vim_session " Quick write session
cnoreabbrev vims Vims " vim_session file written to working dir

" Search for highlighted text, or word under cursor
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
" ------------------------------------------------


" VIM ENVIRONMENT --------------------------------


" Indentation and line width
set expandtab tabstop=2 shiftwidth=2 tw=100 fo-=t

" Fix indentation of just-pasted text
nnoremap gi `[v`]=

" Colors
colorscheme molokai
syntax on
syn match Todo "\DEBUG\>"

" Custom filetype syntax categories, for syntax highlighting
augroup custom_filetypes
  au!
  autocmd BufNewFile,BufRead .envrc set syntax=sh
augroup END

" Powerline settings
set laststatus=2

" NerdCommenter settings
let g:NERDSpaceDelims = 1

" Set tab and indent settings
" NOTE: vim-slueth plugin is in use to heuristically match
" indentation settings of current file, so don't do too much
" manually here.
filetype plugin indent on

" Create a new line from normal mode
noremap <Enter> o<ESC>

" Show line number by default
set number

" Hilighting colors
set hlsearch
hi Search cterm=NONE ctermfg=black ctermbg=yellow
hi PmenuSel cterm=NONE ctermfg=black ctermbg=yellow

" Prefer to open new files in a new tab, or jump to existing tab if file is already open
set switchbuf+=usetab,newtab

" NAVIGATION 
map <C-l> :call MoveRight()<CR>
map <C-h> :call MoveLeft()<CR>
map <C-k> :tabnew<CR>
map <C-j> :call CloseTab()<CR> 
map <C-i> :-tabmove<CR>
map <C-o> :+tabmove<CR>
map <C-g> :vsp<CR>
map <C-t> <C-w>T
map <C-n> :call ToggleQuickFix()<CR>
autocmd FileType qf nnoremap <buffer> <Enter> :.cc<CR>

function! MoveLeft()
  if winnr() == 1
    " current window is only, or leftmost in vertical split
    tabp
  else
    " current window is rightmost in vertical split
    wincmd h
  endif
endfunction

function! MoveRight()
  if winnr() == winnr('$')
    " current window is only, or rightmost in vertical split
    tabn
  else
    " current window is leftmost in vertical split
    wincmd l
  endif
endfunction

function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    ccl
  endif
endfunction

function! CloseTab()
  if winnr('$') == 1
    " current window is only
    q
  else
    " current window is one in vertical split
    wincmd q
  endif
endfunction

"Enable and disable mouse use
" noremap <f1> :call ToggleMouse() <CR>
" function! ToggleMouse()
  " if &mouse == 'a'
    " set mouse=
    " echo "Mouse usage disabled"
  " else
    " set mouse=a
    " echo "Mouse usage enabled"
  " endif
" endfunction

" map <ScrollWheelUp> <C-Y>
" map <ScrollWheelDown> <C-E>
" ------------------------------------------------

noremap <leader>2p :vsp<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr> :set scb<cr>


" PLUGIN MODS ------------------------------------

" vim-fugitive stuff
" Stay on same absolute line (when possible) when moving through history
"nnoremap <silent><C-[> :let line = line('.')<CR>:cn<CR>:exec ':' . line<CR>
"nnoremap <silent><C-]> :let line = line('.')<CR>:cp<CR>:exec ':' . line<CR>

" vim-editorconfig stuff
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" vim-fuzzyfinder stuff
noremap <silent><C-f> :FufFile<CR>
noremap <silent><C-b> :FufBuffer<CR>

" vim-latex settings
let s:latexmk = "~/.vim/latexmk/latexmk.pl -pdf -pvc"
map <C-c> :VimLatexCompileToggle<CR>

" vim-markdown-preview settings
let vim_markdown_preview_github=1  " requires https://github.com/joeyespo/grip
let vim_markdown_preview_toggle=1
let vim_markdown_preview_hotkey='<C-p>'

" vim-lsp and vim-lsp-settings stuff
let g:lsp_diagnostics_enabled = 0  " disable diagnostics support
let g:lsp_document_code_action_signs_enabled = 0  " disable code action markers
let g:lsp_settings_filetype_javascript = ['typescript-language-server']

noremap <leader>def :rightbelow vertical LspDefinition<CR>
noremap <leader>dec :rightbelow vertical LspDeclaration<CR>
noremap <leader>refs :LspReferences<CR>
noremap <leader>hov :LspHover<CR>
noremap <leader>peek :LspPeekDefinition<CR>
noremap <leader>ren :LspRename<CR>
