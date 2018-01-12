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

" syn match mParam '\^.*^' 
" syn match serverName '\w\+AFNAA'
" syn match serverName '\w\+AMNAA'
syn region cmdString start='"' end='"' contains=mParam
syn match cmdOper '#.*' 
syn match cmdOpts 'BS.* ' 
syn keyword cmdOpts START STOP CLEAN REPLACE DIFFS REF OVERLAY
syn keyword commands CLEAN COMPAREDB CONFIG LOADREF LOADCFG WLS FWKS JOB COPY EXECUTE LOADDB ONLINE RUN_DATE SAVEDB SUB GREP SQL TIMER


let b:current_syntax = "job"

hi def link commands Function
hi def link cmdOpts Keyword
hi def link cmdOper Question
hi def link mParam Statement
hi def link serverName Special
hi def link cmdString String
