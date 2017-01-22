" -*- mode: vimrc -*-
"vim: ft=vim

" dotspacevim/auto-install {{{
" Automatic installation of spacevim.

if empty(glob('~/.vim/autoload/spacevim.vim'))
    silent !curl -sSfLo ~/.vim/autoload/spacevim.vim --create-dirs
          \ https://raw.githubusercontent.com/ctjhoa/spacevim/master/autoload/spacevim.vim
endif

" }}}

" dotspacevim/init {{{
" This code is called at the very startup of Spacevim initialization
" before layers configuration.
" You should not put any user code in there besides modifying the variable
" values."
" IMPORTANT: For the moment, any changes in plugins or layers needs
" a vim restart and :PlugInstall

  let g:dotspacevim_distribution_mode = 1

  let g:dotspacevim_configuration_layers = [
  \  'core/.*',
  \  'git',
  \  'syntax-checking'
  \]

  let g:dotspacevim_additional_plugins = ['morhetz/gruvbox']
  " You can also pass vim plug options like this: [{ 'name': 'Valloric/YouCompleteMe', 'option': {'do': './install.py'}}]

  let g:dotspacevim_excluded_plugins = []

  " let g:dotspacevim_escape_key_sequence = 'fd'

" }}}

" dotspacevim/user-init {{{
" Initialization for user code.
" It is compute immediately after `dotspacemacs/init', before layer
" configuration executes.
" This function is mostly useful for variables that need to be set
" before plugins are loaded. If you are unsure, you should try in setting
" them in `dotspacevim/user-config' first."

  let mapleader = ' '
  let g:leaderGuide_vertical = 1

" }}}

call spacevim#bootstrap()

" dotspacevim/user-config {{{
" Configuration for user code.
" This is computed at the very end of Spacevim initialization after
" layers configuration.
" This is the place where most of your configurations should be done.
" Unless it is explicitly specified that
" a variable should be set before a plugin is loaded,
" you should place your code here."

  set background=dark
  colorscheme gruvbox

" }}}
