" -*- mode: vimrc -*-
"vim: ft=vim

" spacevim automatic installation {{{
if empty(glob('~/.vim/autoload/spacevim.vim'))
    silent !curl -fLo ~/.vim/autoload/spacevim.vim --create-dirs
          \ https://raw.githubusercontent.com/ctjhoa/spacevim/master/autoload/spacevim.vim
endif
" }}}

let g:dotspacevim_distribution_mode = 1

let g:dotspacevim_configuration_layers = [
\  'core/.*',
\  'git',
\  'syntax-checking'
\]

let g:dotspacevim_additional_plugins = []

let g:dotspacevim_excluded_plugins = []

" let g:dotspacevim_escape_key_sequence = 'fd'

let mapleader = ' '
let g:leaderGuide_vertical = 1

" This must be the end of the file
call spacevim#bootstrap()
