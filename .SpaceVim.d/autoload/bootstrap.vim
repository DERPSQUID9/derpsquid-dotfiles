function! bootstrap#before() abort
	" Keybindings
	nnoremap <F4> :UndotreeToggle<cr>
	nnoremap <F5> :bp<cr>
	nnoremap <F6> :bn<cr>
	nnoremap <F7> :tabp<cr>
	nnoremap <F8> :tabn<cr>
	nnoremap <leader>? :Cheat40<cr>
	
	" Set fold method to marker
	set foldmethod=marker
	
	" Highlights search and replace matches as you type
	set inccommand=nosplit

	" ALE linters
	let g:ale_linters = {
		\ 'haskell': ['ghc', 'hlint'],
		\ 'bash': ['shellcheck'],
		\ 'rust': ['rls', 'cargo', 'rustc'],
		\}

	let g:ale_fixers = {
		\ '*': ['remove_trailing_lines', 'trim_whitespace'],
		\ 'haskell': ['stylish-haskell'],
		\ 'rust': ['rustfmt'],
		\}
endfunction

"function! bootstrap#after() abort
"endfunction