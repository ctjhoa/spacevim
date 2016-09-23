" -*- mode: vimrc -*-
"vim: ft=vim

" dotspaceneovim/auto-install {{{
  "Automatic installation of spaceneovim.
  if has('nvim')
    let s:config_dir = $HOME . '/.config/nvim'
  else
    let s:config_dir = $HOME . '/.vim'
  endif
  let s:autoload_spaceneovim = expand(resolve(s:config_dir . '/autoload/spaceneovim.vim'))
  if empty(glob(s:autoload_spaceneovim))
      silent execute '!curl -fLo ' . s:autoload_spaceneovim . ' --create-dirs https://raw.githubusercontent.com/tehnix/spaceneovim/master/autoload/spaceneovim.vim'
  endif
" }}}

" dotspaceneovim/layers {{{
  "Configuration Layers declaration.
  "You should not put any user code in this block.
  let g:dotspaceneovim_configuration_layers = [
  \  '+nav/buffers'
  \, '+nav/files'
  \, '+nav/quit'
  \, '+nav/windows'
  \, '+nav/start-screen'
  \, '+nav/text'
  \, '+checkers/neomake'
  \, '+completion/deoplete'
  \, '+tools/terminal'
  \, '+ui/airline'
  \, '+ui/toggles'
  \]

  let g:dotspaceneovim_additional_plugins = [
  \  {'name': 'flazz/vim-colorschemes', 'config': {}}
  \]

  let g:dotspaceneovim_excluded_plugins = []
  " let g:dotspaceneovim_escape_key_sequence = 'fd'
" }}}

" dotspaceneovim/init {{{
  "Initialization block.
  "This block is called at the very startup of Spacemacs initialization
  "before layers configuration.
  "You should not put any user code in there besides modifying the variable
  "values.
  " Map the leader key to <Space>
  let g:mapleader = ' '
  " Shorten the time before the vim-leader-guide buffer appears
  set timeoutlen=100
  " Enable line numbers
  " Set 7 lines to the cursor - when moving vertically using j/k
  set scrolloff=7
  " Use relative line numbers. Options are:
  " - relativenumber/norelativenumber
  " - number/nonumber
  set relativenumber
  " Always show the status line
  set laststatus=2
" }}}

" dotspaceneovim/user-init {{{
  "Initialization block for user code.
  "It is run immediately after `dotspaceneovim/init', before layer
  "configuration executes.
  "This block is mostly useful for variables that need to be set
  "before packages are loaded. If you are unsure, you should try in setting
  "them in`dotspaceneovim/user-config' first."

  " Load external user-init if found
  if filereadable(s:config_dir . '/user-init.vim')
    execute 'source ' . s:config_dir . '/user-init.vim'
  endif
" }}}

call spaceneovim#bootstrap()

" dotspaceneovim/user-config {{{
  "Configuration block for user code.
  "This function is called at the very end of SpaceNeovim initialization after
  "layers configuration.
  "This is the place where most of your configurations should be done. Unless
  "it is explicitly specified that a variable should be set before a package is
  "loaded, you should place your code here."
  " Set default colorscheme to wombat256mod and the background to dark
  set background=dark
  try
    colorscheme wombat256mod
  catch
  endtry

  " Load external user-config if found
  if filereadable(s:config_dir . '/user-config.vim')
    execute 'source ' . s:config_dir . '/user-config.vim'
  endif
" }}}
