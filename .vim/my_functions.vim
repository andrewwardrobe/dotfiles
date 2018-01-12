function SimpleFoldText()
        return getline(v:foldstart).' '
endfunction

function ToDevNull()
        exe "normal a > /dev/null/\e"
endfunction


set foldtext=SimpleFoldText()

au FileType perl so ~/.vim/perl_functions.vim
au FileType sh so ~/.vim/sh_functions.vim
