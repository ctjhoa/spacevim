" ---vim:fdm=marker

" Leader guide

let g:leaderGuide_vertical = 1

" Define prefix dictionary
let g:lmap =  {}

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

function! s:my_displayfunc()
	let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
	let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '^<SID>', '', '')
endfunction
let g:leaderGuide_displayfunc = [function("s:my_displayfunc")]


let g:lmap['<C-I>'] = ['b#', 'last buffer']
let g:lmap['!'] = ['call feedkeys(":! ")', 'shell cmd']
let g:lmap['/'] = ['Ag', 'smart search']

let g:lmap.0 = ['1wincmd w', 'window 0']
let g:lmap.1 = ['2wincmd w', 'window 1']
let g:lmap.2 = ['3wincmd w', 'window 2']
let g:lmap.3 = ['4wincmd w', 'window 3']
let g:lmap.4 = ['5wincmd w', 'window 4']
let g:lmap.5 = ['6wincmd w', 'window 5']
let g:lmap.6 = ['7wincmd w', 'window 6']
let g:lmap.7 = ['8wincmd w', 'window 7']
let g:lmap.8 = ['9wincmd w', 'window 8']
let g:lmap.9 = ['10wincmd w', 'window 9']

let g:lmap[':'] = ['Commands', 'M-x'] " TODO: Keep behavior from Unite command
let g:lmap[';'] = ['''<,''>Commentary', 'vim-commentary-operator']


" applications {{{
let g:lmap.a = { 'name' : 'applications' }
" }}}

" buffers {{{
let g:lmap.b = { 'name' : 'buffers' }
let g:lmap.b.b = ['Buffers', 'fzf-buffers']
let g:lmap.b.d = ['bd', 'kill-this-buffer']
let g:lmap.b.n = ['bnext', 'next-useful-buffer']
let g:lmap.b.p = ['bprevious', 'previous-useful-buffer']
let g:lmap.b.R = ['e', 'safe-revert-buffer']

" buffers/move {{{
let g:lmap.b.m = { 'name' : 'move' }
let g:lmap.b.m.r = ['wincmd r', 'buf-rotate-down-right']
let g:lmap.b.m.R = ['wincmd R', 'buf-rotate-up-left']
" }}}

" }}}

" comile/comments {{{
let g:lmap.c = { 'name' : 'compile/comments' }
" }}}

" capture/colors {{{
let g:lmap.C = { 'name' : 'capture/colors' }
" }}}

" errors {{{
let g:lmap.e = { 'name' : 'errors' }
" }}}

" files {{{
let g:lmap.f = { 'name' : 'files' }
let g:lmap.f.c = ['saveas', 'copy-file']

" files/convert {{{
let g:lmap.f.C = { 'name' : 'files/convert' }
" }}}

let g:lmap.f.D = ['Remove', 'delete-current-buffer-file']
let g:lmap.f.E = ['call feedkeys(":SudoEdit ")', 'sudo-edit']
let g:lmap.f.f = ['Files', 'fzf-find-files']
let g:lmap.f.L = ['call feedkeys(":Locate ")', 'fzf-locate']
let g:lmap.f.r = ['History', 'fzf-recentf']
let g:lmap.f.R = ['call feedkeys(":Rename ")', 'rename-current-buffer-file']
let g:lmap.f.s = ['write', 'save-buffer']
let g:lmap.f.S = ['wa', 'write-all']

" files/vim {{{
let g:lmap.f.e = { 'name' : 'vim' }
let g:lmap.f.e.d = ['edit $MYVIMRC', 'find-dotfile']
let g:lmap.f.e.v = ['version', 'display-vim-version']
" }}}

" }}}

" git/versions-control {{{
let g:lmap.g = { 'name' : 'git/versions-control' }
let g:lmap.g.b = ['Gblame', 'fugitive-blame']
let g:lmap.g.i = ['Git init', 'fugitive-init']
let g:lmap.g.l = ['Glog', 'fugitive-log']
let g:lmap.g.r = ['Gread', 'fugitive-checkout-current-file']
let g:lmap.g.r = ['Gremove', 'fugitive-remove-current-file']
let g:lmap.g.s = ['Gstatus', 'fugitive-status']
let g:lmap.g.S = ['call feedkeys(":Git add -- ")', 'fugitive-stage-file']
let g:lmap.g.w = ['Gwrite', 'fugitive-stage-current-file']
" }}}

" help/highlight {{{
let g:lmap.h = { 'name' : 'help/highlight' }
" }}}

" insertion {{{
let g:lmap.i = { 'name' : 'insertion' }
let g:lmap.i.j = ['call feedkeys("o")', 'vim-insert-line-below']
let g:lmap.i.k = ['call feedkeys("O")', 'vim-insert-line-above']
" }}}

" join/split {{{
let g:lmap.j = { 'name' : 'join/split' }
nnoremap <silent> <SID>indent-region-or-buffer mzgg=G`z
vnoremap <silent> <SID>indent-region-or-buffer ==
nmap <leader>j= <SID>indent-region-or-buffer
vmap <leader>j= <SID>indent-region-or-buffer
let g:lmap.j.j = ['call feedkeys("i\<CR>\<Esc>")', 'sp-newline']
let g:lmap.j.J = ['call feedkeys("i\<CR>\<Esc>")', 'split-and-newline'] " same as j.j ?
let g:lmap.j.o = ['call feedkeys("i\<CR>\<Esc>k$")', 'open-line']
" }}}

" lisp {{{
let g:lmap.k = { 'name' : 'lisp' }
" }}}

" narrow/numbers {{{
let g:lmap.n = { 'name' : 'narrow/numbers' }
" }}}

" projects {{{
let g:lmap.p = { 'name' : 'projects' }
let g:lmap.p.f = ['GitFiles', 'fzf-project-find-file']
" }}}

" quit {{{
let g:lmap.q = { 'name' : 'quit' }
let g:lmap.q.q = ['quit', 'prompt-kill-vim']
let g:lmap.q.Q = ['!quit', 'kill-vim']
let g:lmap.q.r = ['source $MYVIMRC', 'reload-vimrc']
let g:lmap.q.s = ['xa', 'save-buffers-kill-vim']
" }}}

" registers/rings {{{
let g:lmap.r = { 'name' : 'registers/rings' }
" }}}

" search/symbol {{{
let g:lmap.s = { 'name' : 'search/symbol' }
" }}}

" toggles {{{
let g:lmap.t = { 'name' : 'toggles' }
" }}}

" UI toggles/themes {{{
let g:lmap.T = { 'name' : 'UI toggles/themes' }
" }}}

" windows {{{
let g:lmap.w = { 'name' : 'windows' }
let g:lmap.w['-'] = ['split', 'split-window-below']
let g:lmap.w['/'] = ['vsplit', 'split-window-right']
let g:lmap.w['='] = ['wincmd =', 'balance-windows']
let g:lmap.w.h = ['wincmd h', 'window-left']
let g:lmap.w.H = ['wincmd H', 'window-move-far-left']
let g:lmap.w.j = ['wincmd j', 'window-down']
let g:lmap.w.J = ['wincmd J', 'window-move-far-down']
let g:lmap.w.k = ['wincmd k', 'window-up']
let g:lmap.w.K = ['wincmd K', 'window-move-far-up']
let g:lmap.w.l = ['wincmd l', 'window-right']
let g:lmap.w.L = ['wincmd L', 'window-move-far-right']
let g:lmap.w.m = ['call MaximizeToggle()', 'maximize-buffer']
let g:lmap.w.s = ['split', 'split-window-below']
let g:lmap.w.S = ['split | wincmd w', 'split-window-below-and-focus']
let g:lmap.w.v = ['vsplit', 'split-window-right']
let g:lmap.w.V = ['vsplit | wincmd w', 'split-window-right-and-focus']
let g:lmap.w.w = ['wincmd w', 'other-window']
" }}}

" text {{{
let g:lmap.x = { 'name' : 'text' }
" }}}

" zoom {{{
let g:lmap.z = { 'name' : 'zoom' }
" }}}



" Helper functions

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction
