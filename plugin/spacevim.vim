
" Define prefix dictionary
let g:lmap =  {}

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

let g:lmap['/'] = ['Unite grep:.', 'smart search']

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

let g:lmap[':'] = ['Unite command', 'M-x']
let g:lmap[';'] = ['Commentary', 'vim-commentary-operator']

let g:lmap.a = { 'name' : 'applications' }
let g:lmap.b = { 'name' : 'buffers' }
let g:lmap.c = { 'name' : 'compile/comments' }
let g:lmap.C = { 'name' : 'capture/colors' }
let g:lmap.e = { 'name' : 'errors' }
let g:lmap.f = { 'name' : 'files' }
let g:lmap.g = { 'name' : 'git/versions-control' }
let g:lmap.h = { 'name' : 'unite/help/highlight' }
let g:lmap.i = { 'name' : 'insertion' }
let g:lmap.j = { 'name' : 'join/split' }
let g:lmap.k = { 'name' : 'lisp' }
let g:lmap.n = { 'name' : 'narrow/numbers' }
let g:lmap.p = {
                        \'name' : 'projects',
                        \'f' : ['Unite file_rec/async', 'unit-find-file'],
                        \}
let g:lmap.q = { 'name' : 'quit' }
let g:lmap.r = { 'name' : 'registers/rings' }
let g:lmap.s = { 'name' : 'search/symbol' }
let g:lmap.t = { 'name' : 'toggles' }
let g:lmap.T = { 'name' : 'UI toggles/themes' }
let g:lmap.w = { 'name' : 'windows' }
let g:lmap.x = { 'name' : 'text' }
let g:lmap.z = { 'name' : 'zoom' }

