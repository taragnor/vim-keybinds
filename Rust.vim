function! ExecTest() 
  execute "!clear"
  execute "!cargo run"
endfunction

function! ExecRustTest()
  execute "!clear"
  execute "!cargo test"
endfunction

command! EXECRUSTTEST call ExecRustTest(<f-args>)
nmap <F10> :EXECRUSTTEST<CR>


