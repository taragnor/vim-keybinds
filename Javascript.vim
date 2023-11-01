set shiftwidth=3
  :ab clog console.log
  :ab cdeb console.debug
  :ab cwarn console.warn
  :ab cerr console.error

  :ab asnyc async
  :ab ansyc async

"This is all old and used only for very old JS

" set foldmethod=indent
" set foldlevel=6

" if !exists("*JSDefineClass")
"   function JSDefineClass(...)
" 	 let NumArgs= a:0
" 	 let FName= a:1
" 	 let argg1="ofunction ".FName." () { \<cr> \<tab>this.initialize.apply(this, arguments);\<cr>};\<esc><<o\<esc>"
" 	 let argg2=""
" 	 if NumArgs>1
" 		let baseClass= a:2
" 		let argg2="o".FName.".prototype = Object.create(".baseClass.".prototype); \<cr>".FName.".prototype.constructor = ".FName.";\<cr>\<esc>"
" 	 endif
" 	 let argg3= "o".FName.".prototype.initialize = function() {\<cr>};\<esc><<o\<esc>"
" 	 let cmda= "normal! ".argg1.argg2.argg3
" 	 let g:lastClass= FName
" 	 execute cmda
"   endfunction

"   function! JSCreateAutoFunction(...)
" 	  let NumArgs= a:0
" 	  let argList = a:000
" 	  let FunctionName= a:1
" 	  let curr = 1
" 	  let argString = ""
" 	  while curr < NumArgs
" 		  let current = argList[curr]
" 		  let argString = argString." ".current
" 		  let curr = curr + 1
" 	  endwhile
" 	  let className= JSGetClassName()
" 	  if (strlen(className) > 0)
" 		  execute "normal! "."o".className.".prototype.".FunctionName." = function (".argString." ) {\<cr>};\<cr>\<esc>"
" 		  return 1
" 	  endif
" 	  let sclassName= JSGetStaticClassName()
" 	  if (strlen(sclassName) > 0)
" 		  execute "normal! "."o".sclassName.".".FunctionName." = function (".argString." ) {\<cr>};\<cr>\<esc>"
" 		  return 2
" 	  endif
" 	  return 0
"   endfunction

"   function JSGetStaticClassName()
" 	 let register = @o
" 	 let reval = ""
" 	 let currPos= getcurpos()
" 	 let pattern ='\v^function[ ]*([a-zA-Z_]+)'
" 	 let searchRes = search(pattern, "bW")
" 	 if (searchRes > 0)
" 		let matches = matchlist(getline('.'), pattern)
" 		" execute "normal! ".'b"oyaw'
" 		let retval = matches[1]
" 		call setpos('.', currPos)
" 		" let retval =  @o
" 	 endif
" 	 let @o = register
" 	 return retval
"   endfunction

"   function JSGetClassName()
" 	  let register = @o
" 	  let retval = ""
" 	  let currPos= getcurpos()
" 	  let pattern ='\v^([a-zA-Z_.]+)\.prototype\.[a-zA-z_ =]+[(]'
" 	  let searchRes = search(pattern, "bW")
" 	  " let searchRes = search('\v.prototype.[a-zA-z =]+[(]', "bW")
" 	  if (searchRes > 0)
" 		  let matches = matchlist(getline('.'), pattern)
" 		  " execute "normal! ".'b"oyaw'
" 		  call setpos('.', currPos)
" 		  let retval = matches[1]
" 		  " let retval =  @o
" 	  endif
" 	  let @o = register
" 	  return retval
"   endfunction

"   function JSCreateAccessors(varName)
" 	 let cName= JSGetClassName()
" 	 if (strlen(cName) > 0)
" 		let cmd1="o".cName.".prototype.".a:varName." = function () {\<esc>^2f.l"."o\<tab>return this._".a:varName.";\<esc>o};\<esc><<o\<esc>"
" 		execute "normal! ".cmd1
" 		let cmd2="o".cName.".prototype.set".a:varName." = function (newval) {\<esc>^2f.4l~"."o\<tab>this._".a:varName."= newval;\<cr>};\<esc><<o\<esc>"
" 		execute "normal! ".cmd2
" 	 endif
"   endfunction

"   function JSCreateSetterGetter(arg1)
" 	 let className= JSGetClassName()
" 	 if (strlen(className > 0) )
" 		execute "normal! "."oObject.defineProperty (".className.".prototype, '".a:arg1."', {\<esc>"
" 		execute "normal! "."oget: function () {\<cr>},\<cr>set: function(val) {\<cr>},\<cr>configurable:true\<cr>});\<cr>\<esc>"
" 	 endif
"   endfunction

"   function JSGotoDefinition_sameFile(FName)
" 	  " execute "normal! m'"
" 	  let FullFName=a:FName.".prototype.initialize"
" 	  " execute "normal! /".FullFName."\<cr>"
" 	  let searchStr = '\v^[a-zA-Z_ .]*'.a:FName.'\.prototype\.initialize[ ]*[=]'
" 	  let searchRes = search(searchStr, "sbw")
" 	  if (searchRes > 0)
" 		  execute "normal! f.lm'zz"
" 		  return 1
" 	  endif
" 	  " let pattern = '\v^[ .A-Za-z_]+.'.a:FName.' *[=] *a*s*y*n*c* *function[ ]*\('
" 	  let pattern = '\v^[ .A-Za-z_]+[.]'.a:FName.' *[=] *a*s*y*n*c* *function[ *]*\('
" 	  let searchRes = search(pattern, "sbw")
" 	  if (searchRes > 0)
" 		  execute "normal! lm'zz"
" 		  return 1
" 	  endif
" 	  let pattern = '\v^\s*function '.a:FName.'[ ]*\([^)]*\)'
" 	  let searchRes = search(pattern, "sbw")
" 	  if (searchRes > 0)
" 		  execute "normal! lm'zz"
" 		  return 1
" 	  endif
" 	  " echo "can't find: ".a:FName."... searchstr:".searchStr
" 	  return 0
"   endfunction

"   function! JSGotoDefinition_Directory(FName)
" 	  let Fun = function("JSGotoDefinition_sameFile")
" 	  return GotoDefinition_Directory(a:FName, "js", Fun)
"   endfunction


"   function GetClass(CName)
" 	 let regex = '\v\b[^c]?class.+\b([a-zA-Z_]+)[^{]?\{([^}]*)*?\}+/gm'
" 	 let match = matchstr(a:CName,regex)
" 	 " let searchRes = search(regex, "sbw")
" 	 " echo searchRes
"   endfunction


"   " JSFunction
"   command! -nargs=1 SG call JSCreateSetterGetter(<f-args>)
"   command! -nargs=1 ACC call JSCreateAccessors(<f-args>)
"   command! -nargs=* CLASS call JSDefineClass(<f-args>)
"   command! -nargs=* FN call JSCreateAutoFunction(<f-args>)
"   command! -nargs=1 DEF call JSGotoDefinition_Directory(<f-args>)
"   command! FL execute "normal! ithrow new Error(' Finish Function Later'); // TODO: Finish Later<esc>"
"   " nnoremap <silent> gd :call JSGotoDefinition_sameFile(expand("<cword>"))<cr>
"   " nnoremap <silent> gD :call JSGotoDefinition_Directory(expand("<cword>"))<cr>
"   nnoremap <silent> guc :call GetClass("")<cr>
" endif
