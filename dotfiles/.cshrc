#!/bin/csh -f
if ( -e ~/.cshrc.env ) then
	source ~/.cshrc.env
endif

if ( -e ~/.aliases ) then 
	source ~/.aliases
endif

if ( -e ~/.cshrc.model ) then 
	source ~/.cshrc.model
endif
	
if ( -e ~/.mycshrc ) then 
	source ~/.mycshrc
endif
