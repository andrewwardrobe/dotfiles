" Vim syntax file for Maestro jobs
" Author: Andrew Wardrobe
"
"

if exists("b:current_syntax")
	finish
endif

" Fold This based on indents like python
set foldmethod=indent
set foldnestmax=2
" Keywords

syn match mParam '\^.*^' 
syn match serverName '\w\+AFNAA'
syn match serverName '\w\+AMNAA'
syn match cmdOper '#'
syn region cmdString start='"' end='"' contains=mParam
syn keyword schedCmds SCHEDULE FOLLOWS NEEDS AT ON DAYS RUNCYCLE END
syn keyword cmdOpts STOP UNIX WINDOWS WIN


let b:current_syntax = "scheds"

hi def link schedCmds Function
hi def link serverName Special
hi def link cmdOper Statement
hi def link cmdString String
