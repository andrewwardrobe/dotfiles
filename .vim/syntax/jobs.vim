" s
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
syn region cmdString start='"' end='"' contains=mParam
syn match cmdOper '#'
syn keyword jobCommands DOCOMMAND STREAMLOGON TASKTYPE RECOVERY DESCRIPTION
syn keyword cmdOpts STOP UNIX WINDOWS WIN


let b:current_syntax = "job"

hi def link jobCommands Function
hi def link cmdOpts Keyword
hi def link cmdOper Keyword
hi def link mParam Statement
hi def link serverName Special
hi def link cmdString String
