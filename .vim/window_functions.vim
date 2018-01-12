" Some Window Management Stuff
" Author: AWAR


let s:_current_dir = expand("%:p:h")."/"


function Filelist()
	
	let command = "ls ".s:_current_dir."" 
	let a = system(command)

	let lst = split(a)
	
	
	exe "normal i..\n\e"

	for itm in lst
		if !isdirectory(itm)
			exe "normal i".itm."\n\e"
		else
			exe "normal i".itm."/\n\e"
		endif
		
	endfor
	exe "normal dd\e"
endfunction

function _new_dir(newDir)
	if a:newDir == ".."
		
		let tmp = s:_current_dir 
		let last = strridx(tmp, "/")
		let lastbutone = strridx(tmp, "/",last -1)
		let tmp = strpart(tmp, 0, lastbutone +1) 
	else
		let tmp = s:_current_dir . a:newDir
	endif
	return tmp
	
endfunction

function ListDirectoryTab()
	let item = expand("<cword>")
	if isdirectory(item)
		let s:_current_dir = _new_dir(item)

		exe "normal 1GdG"
		call Filelist()
	else
		call FileInNewTab()
	endif
endfunction

function ListDirectoryPanel()
        let item = expand("<cword>")
        if isdirectory(item)
                let s:_current_dir = _new_dir(item)
                exe "normal 1GdG"
                call Filelist()
        else
                call FileInNewPanel()
        endif
endfunction
	
function CreateSideWin()

	if !bufexists("_flist_buffer_")
	 	vne _flist_buffer_
		vertical resize 45
		call Filelist()
	else
		bwipeout! _flist_buffer_
		let s:_current_dir = expand("%:p:h")."/"
	endif
endfunction

function FileInNewTab()
	if @% == "_flist_buffer_"
		wincmd gf
		bwipeout! _flist_buffer_
	else
		wincmd gf
	endif
endfunction

function MousePaste()
	echo "MousePste"
	set paste
	normal! +p
	set nopaste
endfunction


function FileInNewPanel()
	if @% == "_flist_buffer_"
		vertical wincmd f
		bwipeout! _flist_buffer_
	else
		vertical wincmd f
	endif
endfunction


map <F8> :call ListDirectoryTab()<CR>
map <F9> :call ListDirectoryPanel()<CR>

map <F1> :tabnext <CR>
map <F2> :wincmd w<CR>
map <F4> :call CreateSideWin()<CR>
map <S-RightMouse> :call MousePaste()<CR>
command Q quitall



