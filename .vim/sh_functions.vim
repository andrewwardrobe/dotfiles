function! ForLoopKsh(start,end,loopcounter)
        let l = ""
        for i in range(a:start,a:end)
                let l = l." ".i

        endfor
        exe "normal ofor ".a:loopcounter." in ".l."\n\eado\e"
        exe "normal o\e"
        exe "normal odone\eki\t"
endfunction


function! KshHeader()
        exe "normal 1GO#!/usr/bin/ksh\e"
        exe "normal o#################################################\e"
        exe "normal oSCRIPT_DIR=\"$(dirname $(which $0))\"\eo\e"
endfunction

function! IfElseKsh(condition)
        exe "normal aif [[ ".a:condition." ]]\n\eathen\n\e"
        exe "normal o\eaelse\n\n\e"
        exe "normal afi\ekkki\t"
endfunction

function! UntilKsh(condition)
        exe "normal auntil [[ ".a:condition." ]]\n\eado\n\n\e"
        exe "normal adone\eki\t"
endfunction

function! WhileKsh(condition)
        exe "normal awhile [[ ".a:condition." ]]\n\eado\n\n\e"
        exe "normal adone\eki\t"
endfunction

function! IfKsh(condition)
        exe "normal aif [[ ".a:condition." ]]\n\eathen\n\n\e"
        exe "normal afi\eki\t"
endfunction

function! Mkfunc(funcname)
        exe "normal afunction ".a:funcname."\n\ea{\n\n\e"
        exe "normal a}\eki\t"
endfunction

command! Header call KshHeader()
command! -nargs=* FLK call ForLoopKsh(<f-args>)
command! -nargs=* WLK call WhileKsh(<q-args>)
command! -nargs=* KIF call IfKsh(<q-args>)
command! -nargs=* KIFE call IfElseKsh(<q-args>)
command! -nargs=* ULK call UntilKsh(<q-args>)

command! DN call ToDevNull()
command! -nargs=* Mkfunc call Mkfunc(<f-args>)

