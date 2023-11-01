" Contents of init vim(sample)
" let g:OneDrivePath='/mnt/d/OneDrive/'
" let g:VimDataPath=g:OneDrivePath.'vim/'
" execute "source ".g:VimDataPath.'ODRC.vim'

let NERDTreeQuitOnOpen=1

set ff=unix
set encoding=utf-8
set number
set splitright
set splitbelow
set fillchars+=vert:\
set relativenumber
set sessionoptions+=unix,slash,globals
set sessionoptions-=options
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set encoding=utf-8
set tags=./tags,tags;$HOME
filetype plugin on
syntax on
set nocompatible
set softtabstop=3
set tabstop=3
set expandtab
let mapleader=','

set hidden
set scrolloff=12
set sidescrolloff=12

"Cursor settings:
set guicursor=a:blinkon100
set expandtab
set autoread
set history=1000
set updatetime=300
" set redrawtime=10000

if !(has("nvim"))
  let &t_SI.="\e[5 q" "SI = INSERT mode
  let &t_SR.="\e[5 q" "SR = REPLACE mode
  let &t_EI.="\e[1 q" "EI = NORMAL mode
  let g:nvim=1
endif
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



" let g:syntastic_javascript_checkers = ['jsl']
" Tab Autocomplete
" inoremap <tab> <C-N>
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
inoremap <S-tab> <C-P>

"Terminal Pasting Remap
if (has("nvim"))
  tnoremap <expr> <C-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'
else
  tnoremap <expr> <C-r> '<C-W>"'.nr2char(getchar())
endif

if (has("nvim"))
  :set invhlsearch " disable search highlighting
endif

"Terminal Escaping
tnoremap jk <C-\><C-N>
tnoremap <C-[> <C-\><C-N>


"Fast Window Nav (alt key)
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
tnoremap <C-h> <C-\><C-N><C-W>h
tnoremap <C-j> <C-\><C-N><C-W>j
tnoremap <C-k> <C-\><C-N><C-W>k
tnoremap <C-l> <C-\><C-N><C-W>l
nnoremap <A-l> <C-l>

"Fast Insert
"nnoremap <leader>i "=nr2char(getchar())<cr>P   doesn't handle enter
nnoremap <leader>i i_<Esc>r

"Auto terminal
if (has("nvim"))
  nnoremap <A-t> 9<C-W>l:vs<CR><C-W>l:term<CR>i
  command! Term execute "normal! :vs\<CR>\<C-W>l:term\<CR>i"
else
  " nnoremap <A-t> :vs<CR><C-W>l:term<CR><C-\><C-N><C-W>j:q<CR>i
  nnoremap <A-t> :vs<CR><C-W>l:term ++curwin<CR>
  command! Term execute "normal! :vs\<CR>\<C-W>l:term ++curwin\<CR>"
endif

function! Smart_TabComplete()
  let line = getline('.')                         " current line
  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
	 return "\<tab>"
  endif
  return "\<C-N>"
  " let has_period = match(substr, '\.') != -1      " position of period, if any
  " let has_slash = match(substr, '\/') != -1       " position of slash, if any
  " if (!has_period && !has_slash)
  " return "\<C-X>\<C-P>"                         " existing text matching
  " elseif ( has_slash )
  " return "\<C-X>\<C-F>"                         " file matching
  " else
  " return "\<C-X>\<C-O>"                         " plugin matching
  " endif
endfunction

" Window Swap Settings
" let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <C-W>e :call WindowSwap#EasyWindowSwap()<CR>

" Protect enter remapping
:autocmd CmdwinEnter * nnoremap <CR> <CR>
:autocmd BufReadPost quickfix nnoremap <CR> <CR>

set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
	 if getbufvar(bufnr, "&modified")
		let label = '+'
		break
	 endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
	 " give a name to no-name documents
	 if &buftype=='quickfix'
		let name = '[Quickfix List]'
	 else
		let name = '[No Name]'
	 endif
  else
	 " get only the file name
	 let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

"Vim vs Neo Vim Plugins
if (has("nvim"))
  call plug#begin('~/.vim/plugged')
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'tpope/vim-fugitive', {'branch': 'master'}
  Plug 'tpope/vim-surround', {'branch': 'master'}
  Plug 'tpope/vim-commentary', {'branch': 'master'}
  Plug 'vim-airline/vim-airline', {'branch': 'master'}
  Plug 'jszakmeister/vim-togglecursor', {'branch': 'master'}
  Plug 'vim-python/python-syntax', {'branch': 'master'}
  Plug 'pangloss/vim-javascript', {'branch': 'master'}
  Plug 'wesQ3/vim-windowswap', {'branch': 'master'}
  Plug 'vim-python/python-syntax', {'branch': 'master'}
  Plug 'neovimhaskell/haskell-vim', {'branch': 'master'}
  Plug 'bitc/vim-bad-whitespace', {'branch': 'master'}
  Plug 'hail2u/vim-css3-syntax', {'branch': 'master'}
  Plug 'mustache/vim-mustache-handlebars', {'branch': 'master'}
  Plug 'rust-lang/rust.vim', {'branch': 'master'}
  Plug 'bfrg/vim-cpp-modern', {'branch': 'master'}
  Plug 'jason0x43/vim-js-indent', {'branch': 'master'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/nerdtree', {'branch': 'master'}
  Plug 'preservim/nerdtree', {'branch': 'master'}
  Plug 'ap/vim-css-color', {'branch': 'master'}
  Plug 'dracula/vim', {'branch' : 'master'}
  Plug 'leafgarland/typescript-vim', {'branch' : 'master'}

  call plug#end()
  " set guicursor=a:blinkon100
  "NOTE type :PlugUpdate to install/update plugins
else
  call pathogen#infect()
  " Syntastic
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  " Syntastic end
endif



" *******************************************
" CoC Settings

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>E <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>e <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
function! s:show_documentation()
  if (index(['vim''help'], &filetype) >= 0)
	 execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
	 call CocActionAsync('doHover')
  else
	 execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction'

" END COC SETTINGS
" *******************************************

if (has('neovide'))
	 colo dracula
endif

if (has('nvim') && !has('neovide') )
  if (!nvim_list_uis()[0]['ext_termcolors'] != 1) " color check  
	 colo OceanicNext
  else
	 colo dracula
  endif
else " standard gvim
  colo desert "default for gvim
endif

"Turn off Autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"Helper Functions

function! ActionThenRevertRe(str)
  let currPos= getcurpos()
  execute "normal! ".a:str
  call setpos('.', currPos)
endfunction

function! ActionThenRevert(str)
  let currPos= getcurpos()
  execute "normal! ".a:str
  call setpos('.', currPos)
endfunction


" Session Save/Restore
let g:SessionsPath= '~/vimsessions/'
"let g:SessionsPath= g:OneDrivePath.'vim/sessions/'
" execute "command! RS source ".g:SessionsPath.'baseSession'
" execute "command! SS mksession! ".g:SessionsPath.'baseSession <bar> wa'
" execute "command! RS2 source ".g:SessionsPath.'Session2'
" execute "command! SS2 mksession! ".g:SessionsPath.'Session2 <bar> wa'
" execute "command! RS3 source ".g:SessionsPath.'Session3'
" execute "command! SS3 mksession! ".g:SessionsPath.'Session3 <bar> wa'

command! EXECTEST call ExecTest(<f-args>)
command! -nargs=* SETTEST call SetTestVariable(<f-args>)
command! -nargs=1 RS call LoadSession(<f-args>)
command! -nargs=0 CS call ClearSession(<f-args>)
command! SS call SaveToSession()
command! -nargs=1 NS call NewSession(<f-args>)
command! W w
noremap S :call SaveToSession()<CR>


function! NewSession(sessionNum)
  let g:SessionNum=a:sessionNum
  echo "Session Num set to ".g:SessionNum
endfunction

function! ClearSession()
  let g:SessionNum=""
  execute "%bd!"
endfunction

function! LoadSession(sessionNum)
  execute "%bd!"
  execute "source ".g:SessionsPath.'Session'.a:sessionNum
  let g:SessionNum=a:sessionNum
  " echo "Session ".g:SessionNum." Loaded."
endfunction

function! SaveToSession()
  if (exists("g:SessionNum"))
	 execute "mksession! ".g:SessionsPath.'Session'.g:SessionNum
	 execute "wa"
	 echo "Session ".g:SessionNum." Saved"
  else
	 execute "wa"
	 echo "Basic Save only : NO SESSION ACTIVE"
  endif
endfunction

function! SetTestVariable(...)
  let NumArgs= a:0
  let c=1
  let g:TestPath=''
  " let g:TestPath='./'
  while c<=NumArgs
	 let pathvar = get(a:, c, 0)
	 let g:TestPath=g:TestPath.pathvar.' '
	 let c=c+1
  endwhile
  echo "TestPath:".g:TestPath
endfunction

function! ExecTest()
  let pathHeader=""
  if (!has("win32"))
	 execute "!clear"
	 let pathHeader='./'
  endif
  if exists("g:TestPath")
	 execute "!".pathHeader.g:TestPath
  else
	 execute "!make"
  endif
endfunction



set laststatus=2
set ignorecase
set smartcase
syntax on
filetype plugin indent on
" colo desert
set number
set tabstop=3
set shiftwidth=2
set smarttab autoindent
set noexpandtab
set viminfo='1000,f1
nnoremap <leader>rc :execute ":tabnew ".g:VimDataPath."ODRC.vim" <bar> :execute "vsplit ".g:VimDataPath."Javascript.vim"<cr>

"set Directory
nnoremap <leader>sd :cd %:p:h

execute "command! EVRC tabnew ".g:VimDataPath."ODRC.vim"
execute "command! EJSRC tabnew ".g:VimDataPath."Javascript.vim"
execute "command! EPYRC tabnew ".g:VimDataPath."Python.vim"
execute "command! EHSRC tabnew ".g:VimDataPath."Haskell.vim"
execute "command! ETF tabnew ".g:VimDataPath."Testfile.vim"
execute "command! STF source ".g:VimDataPath."Testfile.vim"

" Easy Escape from Insert Mode
:inoremap jk <esc>

"Nerd tree

"Toggle Nerdtree if open, else open up with NERDTreeFind
nnoremap <expr> <A-n> g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'

"" Remap Tabbing

nnoremap <F1> 1gt
nnoremap <F2> 2gt
nnoremap <F3> 3gt
nnoremap <F4> 4gt
nnoremap <F5> 5gt
nnoremap <F6> 6gt
nnoremap <F7> 7gt
nnoremap <F8> 8gt
nnoremap <F9> 9gt
nmap <F11> :EXECTEST<CR>
nmap <F12> <leader>wt

"Test Impelmentation
nmap <leader>t :EXECTEST<CR>


" Better indentation
nnoremap <Tab> >>
nnoremap <S-Tab> <<

"Set Autocenter
nnoremap G Gzz
nnoremap gg ggzz
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz
nnoremap * *zz
nnoremap # #zz
nnoremap <C-o> <C-o>zz
nnoremap <C-p> <C-i>zz

"Easier register Access
nnoremap ; "
nnoremap ;p "0
nnoremap ;t "+
vnoremap ; "
vnoremap ;p "0
vnoremap ;t "+

inoremap <C-r><C-r> <C-r>0
cnoremap <C-r><C-r> <C-r>0

inoremap <C-r>t <C-r>+
cnoremap <C-r>t <C-r>+

"Search on Register

nnoremap <C-s><C-s> /<C-r>0<CR>zz
nnoremap <C-s>a /<C-r>a<CR>zz
nnoremap <C-s>b /<C-r>b<CR>zz
nnoremap <C-s>c /<C-r>c<CR>zz
nnoremap <C-s>d /<C-r>d<CR>zz
nnoremap <C-s>e /<C-r>e<CR>zz
nnoremap <C-s>f /<C-r>f<CR>zz
nnoremap <C-s>g /<C-r>g<CR>zz
nnoremap <C-s>h /<C-r>h<CR>zz
nnoremap <C-s>i /<C-r>i<CR>zz
nnoremap <C-s>j /<C-r>j<CR>zz
nnoremap <C-s>k /<C-r>k<CR>zz
nnoremap <C-s>l /<C-r>l<CR>zz

nnoremap <S-CR> :call Newlineins()<CR>

function! Newlineins()
  let pos = getcurpos()
  echo "Go"
  execute "normal! i\<CR>"
  call setpos('.', pos)
endfunction

"Search using Grep
command! -nargs=1 SEARCH call ExecuteGrepSearch(<f-args>)

function! ExecuteGrepSearch (searchstring)
  execute "grep ".a:searchstring." *.js"
  execute "cw"
endfunction

"up/down motions work visually
"nnoremap j gj
"nnoremap k gk

"generic recenter
nnoremap <C-F> <C-F>zz
nnoremap <C-B> <C-B>zz


"recenter after search

function! CenterSearch()
  let cmdtype = getcmdtype()
  if cmdtype == '/' || cmdtype == '?'
	 return "\<enter>zz"
  endif
  return "\<enter>"
endfunction

cnoremap <silent> <expr> <enter> CenterSearch()

"Mark Swap (makes ' the instant jump)
nnoremap ` '
nnoremap ' `



"Delete-Replace
nnoremap dr :let test = v:register<esc>"_ciw<c-r>=getreg(test)<cr><esc>
nnoremap dR :let test = v:register<esc>"_ciW<c-r>=getreg(test)<cr><esc>
" nnoremap dr diw"0P
" nnoremap ;adr diw"aP
" nnoremap ;bdr diw"bP
" nnoremap ;ddr diw"dP
" nnoremap ;edr diw"eP


" Arrow Redef

nnoremap <down> <C-D>zz
nnoremap <up> <C-U>zz
nnoremap <left> g;
nnoremap <right> g,

"QUick Pairs

inoremap <leader>' ''<esc>i
inoremap <leader>" ""<esc>i
inoremap <leader>{ {}<esc>i
inoremap <leader>( ()<esc>i
inoremap <leader>[ []<esc>i

"Quick format
" nnoremap <leader>f m'=ip<C-o>
nnoremap <leader>f :call ActionThenRevert("=ip")<cr>

"Quick modify arguments/parameters
" nnoremap <leader>p {jf(l
" nmap <leader>p [[<<f(l
nmap <leader>p {j<<f(l

" select params in operator pending
:onoremap <leader>pp :normal {j<<f(lvi(<cr> 
:onoremap <leader>p1 :normal {j<<f(wviw<cr> 
:onoremap <leader>p2 :normal {j<<f,wviw<cr>
:onoremap <leader>p3 :normal {j<<2f,wviw<cr>
:onoremap <leader>p4 :normal {j<<3f,wviw<cr>
:onoremap <leader>p5 :normal {j<<4f,wviw<cr>
:onoremap <leader>p6 :normal {j<<5f,wviw<cr>
:onoremap <leader>p7 :normal {j<<6f,wviw<cr>
" :onoremap <leader>p1 :call ActionThenRevertRe("[[<<f(wviw<cr>")
" :onoremap <leader>p2 :call ActionThenRevertRe("[[<<f,wviw<cr>")
" :onoremap <leader>p3 :call ActionThenRevertRe("[[<<2f,wviw<cr>")
" :onoremap <leader>p4 :call ActionThenRevertRe("[[<<3f,wviw<cr>")
" :onoremap <leader>p5 :call ActionThenRevertRe("[[<<4f,wviw<cr>")
" :onoremap <leader>p6 :call ActionThenRevertRe("[[<<5f,wviw<cr>")
" :onoremap <leader>p7 :call ActionThenRevertRe("[[<<6f,wviw<cr>")


"Bracket Fix
:map [[ ?{<CR>w99[{
:map ][ /}<CR>b99]}
:map ]] j0[[%/{<CR>
:map [] k$][%?}<CR>


"load Language Specific
augroup file_typevim
  autocmd!
  execute 'autocmd FileType rust :source '.g:VimDataPath.'Rust.vim'
  execute 'autocmd FileType javascript :source '.g:VimDataPath.'Javascript.vim'
  execute 'autocmd FileType typescript :source '.g:VimDataPath.'Javascript.vim'
  execute 'autocmd FileType python :source '.g:VimDataPath.'Python.vim'
  execute 'autocmd FileType haskell :source '.g:VimDataPath.'Haskell.vim'
augroup END

execute "command! CTAGS ! ctags -R ."

function! BannerCmd(txt)
  let modTxt = "   ".a:txt."   "
  let padding = (50 - strlen(modTxt)) /2
  execute "normal! "."o\<esc>50i*\<esc>"."o\<esc>".padding."i*\<esc>i".modTxt."\<esc>".padding."i*\<esc>"."o\<esc>50i*\<esc>o\<esc>" 
  execute "normal "."3k3gcc3j"
endfunction

command! -nargs=1 BAN call BannerCmd(<f-args>)

" ABBREVIATIONS
ab wieght weight
ab weihgt weight
ab hieght height
ab heihgt height

" Applying codeAction to the selected region.
" Example: `<leader>Aap` for current paragraph
xmap <leader>A  <Plug>(coc-codeaction-selected)
nmap <leader>A  <Plug>(coc-codeaction-selected)

" Apply codeAction to current cursor position
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" SEARCH FUNCTIONS
function! GotoDefinition_allBuffers(FName, SearchFn)
  let hidden = &hidden
  execute "set hidden"
  let startBuffer = bufnr("%")
  let lastBuffer = bufnr("$")
  let buffers = filter(range(1, lastBuffer), 'bufexists(v:val)')
  for buffer in buffers
	 execute "b".buffer
	 if (a:SearchFn(a:FName) )
		if (hidden == 0)
		  set hidden!
		endif
		let targetbuf = bufnr("%")
		if (targetbuf != startBuffer)
		  execute "b".startBuffer
		  execute "vs"
		  execute "normal! \<C-W>l"
		  execute "b".targetbuf
		endif
		return 1
	 endif
  endfor
  execute "b".startBuffer
  if (hidden == 0)
	 set hidden!
  endif
  return 0
endfunction

function! GetFilesInProject(fileExt)
  return GetFilesInDirectory(a:fileExt)
endfunction

function! GetFilesInDirectory(fileExt)
  if (has("win32"))
	 let flist= split(globpath('.', "*.".a:fileExt), "\n")
  else
	 let flist= split(globpath('.', "*.".a:fileExt), "\n")
  endif
  let pattern = '\v[\\/]([A-Za-z0-9_ .]+)'
  let newlist = []
  for file in flist
	 let fname=  matchlist(file, pattern)[1]
	 let newlist = add(newlist, fname)
  endfor
  return newlist
endfunction

function! GotoDefinition_Directory(FName, fileExtension, SearchFn)
  let startBuffer = bufnr("%")
  if (GotoDefinition_allBuffers(a:FName, a:SearchFn))
	 return 1
  endif
  let files = GetFilesInProject(a:fileExtension)
  if len(files) == 0
	 echo "Files length is 0"
	 return 0
  endif
  for file in files
	 let filename=  file
	 if bufexists(filename) == 0
		" execute "badd ".filename
		execute "e ".filename
		let targetbuf = bufnr("%")
		if (a:SearchFn(a:FName))
		  execute "b".startBuffer
		  execute "vs"
		  execute "normal! \<C-W>l"
		  execute "b".targetbuf
		  execute "set buflisted"
		  return 1
		else
		  execute "bdelete ".filename
		  " May want to change to bwipeout
		endif
	 endif
  endfor
  execute "b".startBuffer
  return 0
endfunction
