" Set up path variables {{{
if has('nvim')
  let s:config_dir = $HOME . '/.config/nvim'
else
  let s:config_dir = $HOME . '/.vim'
endif
let s:vim_plug = expand(resolve(s:config_dir . '/autoload/plug.vim'))
let s:vim_plugged = expand(resolve(s:config_dir . '/plugged'))
let s:spaceneovim_layers_dir = expand(resolve(s:config_dir . '/spaceneovim-layers'))
" }}}

" Set up layer variables {{{
let g:spaceneovim_layers = []
let g:spaceneovim_enabled_layers = []
let g:spaceneovim_plugins = []
" }}}

" Set up configurable variables {{{
let s:default_repository = 'https://github.com/Tehnix/spaceneovim-layers.git'
let g:dotspaceneovim_layers_repository = get(g:, 'dotspaceneovim_layers_repository', s:default_repository)
let g:dotspaceneovim_additional_plugins = get(g:, 'dotspaceneovim_additional_plugins', [])
let g:dotspaceneovim_configuration_layers = get(g:, 'dotspaceneovim_configuration_layers', [])
let g:dotspaceneovim_debug = get(g:, 'dotspaceneovim_debug', 0)
" }}}

""
" Debug messages to the console
"
function! s:debug(msg)
  if g:dotspaceneovim_debug
    echo a:msg
  endif
endfunction

function! spaceneovim#check_for_python()
  return has('python') || has('python3')
  " Alternative longwinded way of checking for support
  "let s:check = system('python -c "import neovim" 2> /dev/null && echo $? || echo $?')
  "if s:check ==? "1\n"
  ""  return 0
  "endif
  "return 1
endfunction

""
" Download the SpaceNeovim Layers using git
"
function! spaceneovim#download_layers(repo, location) abort
  if empty(glob(a:location))
    call s:debug('>>> Cloning down ' . a:repo)
    if has('nvim')
      let l:install_layers = jobstart([
      \  'git'
      \, 'clone'
      \, a:repo
      \, a:location
      \])
      let l:waiting_for_layers = jobwait([l:install_layers])
    else
      silent execute '!git clone ' . a:repo . ' ' . a:location
    endif
  endif
endfunction

""
" Find all existing layers
"
function! spaceneovim#find_all_layers(layers_dir) abort
  call s:debug('>>> Locating all layers in ' . a:layers_dir . ':')
  let l:located_layers = []
  for l:group in split(glob(a:layers_dir . '/layers/*'), '\n')
    for l:layer in split(glob(l:group . '/*'), '\n')
      " Make sure the layer is not empty/invalid
      if filereadable(l:layer . '/config.vim') && filereadable(l:layer . '/packages.vim')
        let l:layer_name = substitute(l:layer, a:layers_dir . '/layers/', '', '')
        call add(l:located_layers, l:layer_name)
        call s:debug('    Found ' . l:layer_name)
      endif
    endfor
  endfor
  return l:located_layers
endfunction

""
" Find all enabled layers
"
function! spaceneovim#filter_enabled_layers(located_layers, configured_layers) abort
  call s:debug('>>> Filtering all enabled layers')
  let l:enabled_layers = []
  for l:configuration_layer in a:configured_layers
    for l:layer in a:located_layers
      if l:layer =~ l:configuration_layer
        call add(l:enabled_layers, l:layer)
        call s:debug('    Enabled ' . l:layer)
      endif
    endfor
  endfor
  return l:enabled_layers
endfunction

""
" Setup and install vim-plug
"
function! spaceneovim#setup_vim_plug() abort
  if empty(glob(s:vim_plug))
    call s:debug('>>> Downloading plug.vim')
    if has('nvim')
      let l:install_plug = jobstart([
      \  'curl'
      \, '-fLo'
      \, s:vim_plug
      \, '--create-dirs'
      \, 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      \])
      let l:waiting_for_plug = jobwait([l:install_plug])
    else
      silent execute '!curl -fLo ' . s:vim_plug . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
    call s:debug('>>> Sourcing ' . $MYVIMRC . ' again')
  endif
  if empty(glob(s:vim_plugged))
    call s:debug('>>> Installing all plugins...')
    if has('nvim')
      let l:create_plugged_dir = jobstart(['mkdir', '-p', s:vim_plugged])
      let l:waiting_for_plugged_dir = jobwait([l:create_plugged_dir])
      source $MYVIMRC
      let l:install_plug_packages = jobstart(['nvim', '+PlugInstall', '+qall'])
      let l:waiting_for_packages = jobwait([l:install_plug_packages])
    else
      silent execute '!mkdir -p ' . s:vim_plugged
      source $MYVIMRC
      silent execute '!vim +PlugInstall +qall'
    endif
    source $MYVIMRC
    call s:debug('>>> All plugins installed')
  endif
endfunction

""
" Install plugins from all enabled layers
"
function! spaceneovim#install_enabled_plugins(enabled_layers, plugins, additional_plugins) abort
  call s:debug('>>> Sourcing all layers:')
  call plug#begin(s:vim_plugged)
  Plug 'hecal3/vim-leader-guide'
  " Load all the plugins from the layers
  for l:layer in a:enabled_layers
    execute 'source ' . s:spaceneovim_layers_dir . '/layers/' . l:layer . '/packages.vim'
    execute 'source ' . s:spaceneovim_layers_dir . '/layers/' . l:layer . '/config.vim'
  endfor
  " Add them to plug along with their configuration
  call s:debug('>>> Adding them to plug with their configuration')
  for l:plugin in a:plugins
    Plug l:plugin.name, l:plugin.config
  endfor
  " Install any additionally specified plugins
  call s:debug('>>> Installing additional plugins')
  for l:plugin in a:additional_plugins
    Plug l:plugin.name, l:plugin.config
  endfor
  call plug#end()
endfunction

""
" Bootstrap the SpaceNeovim installation
"
function! spaceneovim#bootstrap() abort
  let l:python_support = spaceneovim#check_for_python()
  if l:python_support ==? 0
    echo 'IMPORTANT! Neovim could not find support for python, which means'
    echo 'some layers may not work. To fix this, install the neovim python'
    echo 'package. Doing `pip install neovim` should work.'
    echo ''
  endif
  call s:debug('>>> Starting SpaceNeovim bootstrap')
  call spaceneovim#download_layers(
    \g:dotspaceneovim_layers_repository,
    \s:spaceneovim_layers_dir
  \)
  let g:spaceneovim_layers = spaceneovim#find_all_layers(
    \s:spaceneovim_layers_dir
  \)
  let g:spaceneovim_enabled_layers = spaceneovim#filter_enabled_layers(
    \g:spaceneovim_layers,
    \g:dotspaceneovim_configuration_layers
  \)

  if filereadable(s:spaceneovim_layers_dir . '/auto-layers.vim')
    execute 'source ' . s:spaceneovim_layers_dir . '/auto-layers.vim'
  endif

  if l:python_support ==? 1
    call spaceneovim#setup_vim_plug()
    call spaceneovim#install_enabled_plugins(
      \g:spaceneovim_enabled_layers,
      \g:spaceneovim_plugins,
      \g:dotspaceneovim_additional_plugins
    \)
  endif
  call s:debug('>>> Finished SpaceNeovim bootstrap')
endfunction
