execute pathogen#infect()
runtime! plugin/sensible.vim
"Recommendation : Write any prefernce setting below this line only
let g:slime_target = "screen"
colorscheme desert
:nnoremap   :cscope f c <cword>
:nnoremap   :cscope f s <cword>
set tabstop=4
set shiftwidth=4

set listchars=tab:>.
set hlsearch
se incsearch
se nu
se ic
if match($TERM,"screen")!=-1
        set term=xterm
endif
