" Vim filetype plugin file
" Language:	VHDL

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
else
au BufRead,BufNewFile *.vhd,*.vhdl		set filetype=vhdl
" Behaves just like Verilog
au BufRead,BufNewFile *.vhd,*.vhdl		runtime! indent/vhdl.vim
endif
