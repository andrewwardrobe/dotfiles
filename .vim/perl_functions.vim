
function! PerlNew()
	exe "normal asub new {\e"
	exe "normal a\nmy ($class_name) = @_;\e"
	exe "normal a\nmy $self = {};\n\e"
	exe "normal a\nbless ($self,$class_name);\n\e"
	exe "normal a\n$self->{_created} = 1;\e"
	exe "normal a\nreturn $self;\e"
	exe "normal a\n}\e"
endfunction

function! PerlHeader()
        exe "normal 1GO#!/usr/bin/perl\n\e"
        exe "normal ouse strict;\e"
        exe "normal ouse 5.010;\n\e"
        exe "normal ouse feature qw(say);\n\n\e"
	exe "normal o"
endfunction

function! Mksub(subname)
        exe "normal asub ".a:subname.""
        exe "normal o{\n\e"
        exe "normal o}\eki\t"
endfunction

function! PerlForEach(list,counter)
        exe "normal aforeach my ".a:counter." (".a:list.")\n\e"
        exe "normal a{\n\e"
        exe "normal o}\eki\t"
endfunction


function! PerlForEachSortHash(list,counter)
        exe "normal aforeach my ".a:counter." (sort keys ".a:list.")\n\e"
        exe "normal a{\n\e"
        exe "normal o}\eki\t"
endfunction

function! PerlForEachSort(list,counter)
        exe "normal aforeach my ".a:counter." (sort ".a:list.")\n\e"
        exe "normal a{\n\e"
        exe "normal o}\eki\t"
endfunction

function! PerlIf(condition)
        exe "normal aif (".a:condition.")\n\e"
        exe "normal a{\n\e"
        exe "normal a}\eki\t"
endfunction

function! PerlIfElse(condition)
        exe "normal aif (".a:condition.")\n\e"
        exe "normal a{\n\e"
        exe "normal a}\n\e"
        exe "normal else\n\e"
        exe "normal a{\n\e"
        exe "normal a}\eki\t"
endfunction


function! PerlStripMultipleSpacesReplaceWithComma(varname)
        exe "normal a".a:varname."  =~ s/ +/,/g;\n\e"
endfunction

function! PerlStripMultipleSpaces(varname)
        exe "normal a".a:varname."=~s/ +/ /g;\n\e"
endfunction

function! PerlWhile(condition)
        exe "normal awhile (".a:condition.")\n\e"
        exe "normal a{\n\e"
        exe "normal a}\eki\t"
endfunction

function! PerlInOutFileLoop(infilename,outfilename)
        exe "normal aopen (INFILE,".a:infilename.") or die $!;\n\e"
        exe "normal aopen (OUTFILE,\">\",".a:outfilename.") or die $!;\n\e"
        exe "normal awhile (<INFILE>){\n\n\e"
        exe "normal a}\n\e"
        exe "normal aclose(INFILE);\n\e"
        exe "normal aclose(OUTFILE);\n\ekkkki\t"
endfunction

function! PerlInFileLoop(infilename)

        exe "normal aopen (INFILE,".a:infilename.") or die $!;\n\e"
        exe "normal awhile (<INFILE>){\n\n\e"
        exe "normal a}\n\e"
        exe "normal aclose(INFILE);\n\ekkki\t"
endfunction

function! InhieritedPackage(variables)

	let attr_list = split(a:variables, " ")[2:]
	let base_package = split(a:variables, " ")[1]
	let packname = split(a:variables, " ")[0]

	exe "normal opackage ".packname.";\n\n\e"
	
	exe "normal ouse base qw(".base_package.");\n\e"

	exe "normal asub new {\e"
	exe "normal omy ($class_name) = @_;\e"

	exe "normal omy $super_class = $class_name->SUPER::new();\n\e"

	for attr in attr_list
		exe "normal omy $".attr.";\e"
        endfor
	
	exe "normal oreturn bless sub{\e"
	exe "normal omy ($attribute,@args) = @_;\e"

	for attr in attr_list
		exe "normal oif( $attribute eq '".attr."' ){\e"
		exe "normal oif(@args){\e"
		exe "normal o($".attr.") = @args;\n}\e"
		exe "normal oreturn $".attr.";\n}\n\e"
        endfor
	exe "normal oreturn $super_class->($attribute,@args);\e"	
	exe "normal o} => $class_name;\n}\n\e"

	for attr in attr_list
		exe "normal osub ".attr." {\e"
		exe "normal omy ($self,@args) = @_;\n\e"
		exe "normal oreturn $self->(".attr." => @args); \e"
		exe "normal o}\n\e"
	endfor

	exe "normal GO1;"

endfunction

function! Package(variables)

	let attr_list = split(a:variables, " ")[1:]
	let packname = split(a:variables, " ")[0]

	exe "normal opackage ".packname.";\n\n\e"

	exe "normal asub new {\e"
	exe "normal omy ($class_name) = @_;\e"

	for attr in attr_list
		exe "normal omy $".attr.";\e"
        endfor
	
	exe "normal oreturn bless sub{\e"
	exe "normal omy ($attribute,@args) = @_;\e"

	for attr in attr_list
		exe "normal oif( $attribute eq '".attr."' ){\e"
		exe "normal oif(@args){\e"
		exe "normal o($".attr.") = @args;\n}\e"
		exe "normal oreturn $".attr.";\n}\n\e"
        endfor

	exe "normal o} => $class_name;\n}\n\e"

	for attr in attr_list
		exe "normal osub ".attr." {\e"
		exe "normal omy ($self,@args) = @_;\n\e"
		exe "normal oreturn $self->(".attr." => @args); \e"
		exe "normal o}\n\e"
	endfor

	exe "normal GO1;"

endfunction

command! PHeader call PerlHeader()
command! -nargs=* FLP call PerlForEach(<f-args>)
command! -nargs=* FLPS call PerlForEachSort(<f-args>)
command! -nargs=* FLPSH call PerlForEachSortHash(<f-args>)

command! -nargs=* WIFL call PerlInFileLoop(<q-args>)
command! -nargs=* WIOFL call PerlInOutFileLoop(<f-args>)

command! -nargs=* PSS call PerlStripMultipleSpaces(<q-args>)
command! -nargs=* PSSC call PerlStripMultipleSpacesReplaceWithComma(<q-args>)
command! -nargs=* PIF call PerlIf(<q-args>)
command! -nargs=* PIFE call PerlIfElse(<q-args>)
command! -nargs=* WLP call PerlWhile(<q-args>)
command! -nargs=* NP call Package(<q-args>)
command! -nargs=* INP call InhieritedPackage(<q-args>)
command! -nargs=* Mksub call Mksub(<f-args>)


