set nocompatible

:set nu "line numbers
:set ts=4
:set autoindent
:set softtabstop=4 shiftwidth=4 expandtab
set nowrap

filetype plugin indent on
syntax enable

" statusbar vimairline
set laststatus=2
let g:airline_theme='luna'

" backspace
set backspace=2 "normal backspace behaviour
set backspace=indent,eol,start

set showmatch

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
colorscheme evening
if &diff
     colorscheme desert
     set t_Co=16
     "   highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
      "  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
      "  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
      "  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif

"auto move to search string
set incsearch
"set ignorecase
set hlsearch

nmap <silent> <F2> :copen<CR>
"nmap <silent> <F3> ':vimgrep /' . expand('<cword>') . '/ %'<CR>
nmap <silent> <F3> :vimgrep /<C-R><C-W>/ %<CR>
nmap <silent> <F4> :split<CR>
nmap <silent> <F6> :vsplit<CR>
"nmap <silent> <F5> :NERDTreeToggle<CR>
nmap <silent> <F7> :tabnew<CR>
