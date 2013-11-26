" Vim filetype plugin file
" Language:	SystemVerilog (superset extension of Verilog)

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
else
au BufRead,BufNewFile *.v,*.vh,*.sv		set filetype=verilog_systemverilog
" Behaves just like Verilog
au BufRead,BufNewFile *.v,*.vh,*.sv		runtime! ftplugin/verilog.vim
au BufRead,BufNewFile *.v,*.vh,*.sv		runtime! indent/verilog_systemverilog.vim
endif
