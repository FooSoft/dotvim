setlocal noexpandtab

" vim-argwrap
let b:argwrap_tail_comma = 1

" vim-go
nmap <leader><f5> :GoDebugStart<cr>
nmap <leader><f9> :GoDebugBreakpoint<cr>
nmap <leader>b <plug>(go-build)
nmap <leader>c <plug>(go-coverage)
nmap <leader>r <plug>(go-run)
nmap <leader>t <plug>(go-test)
nmap <s-f11> :GoDebugStepOut<cr>
nmap <s-f5> :GoDebugStop<cr>
