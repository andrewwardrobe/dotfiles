set history=700
"set term=ansi
filetype plugin on
filetype indent on

"let &t_Co=256
"let &t_AF="\e[38;5;%dm"
"let &t_AB="\e[48;5;%dm"

if has("terminfo")
	let &t_Co=16
"	let &t_AB="\<Esc>[%?p1%{8}%<%p1%{40}%+%e%p1%{92}%+%;%dm"
"	let &t_AF="\<Esc>[%?p1%{8}%<%p1%{30}%+%e%p1%{82}%+%;%dm"

	let &t_AF="\<Esc>[3%dm"
	let &t_AB="\<Esc>[4%dm"
else
	let &t_Co=16
	let &t_Sf="\<Esc>[3%dm"
	let &t_Sb="\<Esc>[4%dm"
endif


syntax enable
set magic
set si
set nowrap
"set spell
set background=dark
set number
set ruler
set showcmd
set scrolloff=10
set foldenable
set smartcase

set incsearch
set hlsearch

set foldmarker={,}
set foldmethod=marker
set foldlevel=100
set foldopen=block,hor,mark,percent,quickfix,tag
set iskeyword+=_,$,@,%,#
set complete=k,i,t
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set ttymouse=xterm
set dict+=~/.vim/dict.dic
set wildmode=longest,list,full
set wildmenu

au FileType * exe ('setl dict+='.$VIMRUNTIME.'/syntax/'.&filetype.'.vim')
au BufRead,BufNewFile *.t set filetype=perl
syn match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
hi link ipaddr Identifier
hi Pmenu ctermbg=255 ctermfg=0 gui=bold
"hi Normal ctermfg=green ctermbg=white

so ~/.vim/my_functions.vim
so ~/.vim/supertab.vim
so ~/.vim/window_functions.vim


"nmap <LeftMouse> <nop>
"nmap <2-LeftMouse> <nop>
"imap <LeftMouse> <nop>
"vmap <LeftMouse> <nop>

map <F8> :call ListDirectoryTab()<CR>
map <F9> :call ListDirectoryPanel()<CR>

map <F1> :tabnext <CR>
map <F2> :wincmd w<CR>
map <F4> :call CreateSideWin()<CR>
" imap <S-RightMouse> :call MousePaste()<CR>

command! Q quitall

command SW w !sudo tee % > /dev/null
command SWQ execute 'w !sudo tee % > /dev/null' | quit!


