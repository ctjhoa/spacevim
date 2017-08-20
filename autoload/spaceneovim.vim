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
let g:spaceneovim__private_layers = []
let g:spaceneovim_enabled_layers = []
let g:spaceneovim_enabled_private_layers = []
let g:spaceneovim_plugins = []
" }}}

" Set up configurable variables {{{
let s:default_repository = 'https://github.com/Tehnix/spaceneovim-layers.git'
let g:dotspaceneovim_layers_repository = get(g:, 'dotspaceneovim_layers_repository', s:default_repository)
let g:dotspaceneovim_additional_plugins = get(g:, 'dotspaceneovim_additional_plugins', [])
let g:dotspaceneovim_configuration_layers = get(g:, 'dotspaceneovim_configuration_layers', [])
let g:dotspaceneovim_configuration_private_layers = get(g:, 'dotspaceneovim_configuration_private_layers', [])
let g:dotspaceneovim_debug = get(g:, 'dotspaceneovim_debug', 0)
let g:dotspaceneovim_leader_key = get(g:, 'dotspaceneovim_leader_key', '<Space>')
" }}}

""
" Debug messages to the console.
"
function! s:debug(msg)
  if g:dotspaceneovim_debug
    echo a:msg
  endif
endfunction

""
" Check for python availability.
"
function! spaceneovim#check_for_python()
  return has('python') || has('python3')
endfunction

""
" Download the SpaceNeovim Layers using git.
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
" Find all existing layers.
"
function! spaceneovim#find_all_layers(layers_dir) abort
  call s:debug('>>> Locating all layers in ' . a:layers_dir . ':')
  let l:located_layers = []
  for l:group in split(glob(a:layers_dir . '*'), '\n')
    for l:layer in split(glob(l:group . '/*'), '\n')
      " Make sure the layer is not empty/invalid
      if filereadable(l:layer . '/config.vim') && filereadable(l:layer . '/packages.vim')
        let l:layer_name = substitute(l:layer, a:layers_dir, '', '')
        call add(l:located_layers, l:layer_name)
        call s:debug('    Found ' . l:layer_name)
      endif
    endfor
  endfor
  return l:located_layers
endfunction

""
" Find all enabled layers.
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
" Setup and install vim-plug.
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
" Install plugins from all enabled layers.
"
function! spaceneovim#install_enabled_plugins(enabled_layers, enabled_private_layers, plugins, additional_plugins) abort
  call s:debug('>>> Sourcing all layers')
  call plug#begin(s:vim_plugged)
  " Load all the plugins from the layers.
  for l:layer in a:enabled_layers
    execute 'source ' . s:spaceneovim_layers_dir . '/layers/' . l:layer . '/packages.vim'
    execute 'source ' . s:spaceneovim_layers_dir . '/layers/' . l:layer . '/config.vim'
  endfor
  " Do the same for the private layers.
  for l:layer in a:enabled_private_layers
    execute 'source ' . s:spaceneovim_layers_dir . '/private/' . l:layer . '/packages.vim'
    execute 'source ' . s:spaceneovim_layers_dir . '/private/' . l:layer . '/config.vim'
  endfor
  " Add them to plug along with their configuration.
  call s:debug('>>> Adding them to plug with their configuration')
  for l:plugin in a:plugins
    Plug l:plugin.name, l:plugin.config
  endfor
  " Install any additionally specified plugins.
  call s:debug('>>> Installing additional plugins')
  for l:plugin in a:additional_plugins
    Plug l:plugin.name, l:plugin.config
  endfor
  call plug#end()
endfunction

""
" Bootstrap the SpaceNeovim installation.
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

  " Download the layers from the git repository.
  call spaceneovim#download_layers(
    \g:dotspaceneovim_layers_repository,
    \s:spaceneovim_layers_dir
  \)

  " Locate all enabled layers.
  let g:spaceneovim_layers = spaceneovim#find_all_layers(
    \s:spaceneovim_layers_dir . '/layers/'
  \)
  let g:spaceneovim_enabled_layers = spaceneovim#filter_enabled_layers(
    \g:spaceneovim_layers,
    \g:dotspaceneovim_configuration_layers
  \)
  " Locate all enabled private layers.
  let g:spaceneovim_private_layers = spaceneovim#find_all_layers(
    \s:spaceneovim_layers_dir . '/private/'
  \)
  let g:spaceneovim_enabled_private_layers = spaceneovim#filter_enabled_layers(
    \g:spaceneovim_private_layers,
    \g:dotspaceneovim_configuration_private_layers
  \)

  " Load in functionality from the layers repository.
  if filereadable(s:spaceneovim_layers_dir . '/auto-layers.vim')
    execute 'source ' . s:spaceneovim_layers_dir . '/auto-layers.vim'
  endif

  " Only proceed if we have python support.
  if l:python_support ==? 1
    call spaceneovim#setup_vim_plug()
    call spaceneovim#install_enabled_plugins(
      \g:spaceneovim_enabled_layers,
      \g:spaceneovim_enabled_private_layers,
      \g:spaceneovim_plugins,
      \g:dotspaceneovim_additional_plugins,
    \)
  endif

  call g:Spaceneovim_postinstall()
  call s:debug('>>> Finished SpaceNeovim bootstrap')
endfunction

""
" Set up the commands to use in the configuration file.
"
function! spaceneovim#init()
  command! -nargs=1 -bar Layer        call s:layer(<args>)
  command! -nargs=1 -bar PrivateLayer call s:private_layer(<args>)
  command! -nargs=+ -bar ExtraPlugin  call s:extra_plugin(<args>)
  command! -nargs=+ -bar SetTheme     call s:set_theme(<args>)
  command! -nargs=0 -bar EnableDebug  call s:enable_debugging()
  command! -nargs=1 -bar SetLayerRepo call s:set_layer_repo(<args>)
  command! -nargs=0 -bar GetLeader    call spaceneovim#get_leader_key()
  command! -nargs=1 -bar SetLeader    call spaceneovim#set_leader_key(<args>)
  call s:debug('>>> Initializing Spaceneovim')
endfunction

""
" Add a layer to the layers dictionary.
"
function! s:layer(layer_name)
  call s:debug('--> User added layer ' . a:layer_name)
  if index(g:dotspaceneovim_configuration_layers, a:layer_name) ==? -1
    call add(g:dotspaceneovim_configuration_layers, a:layer_name)
  endif
endfunction

""
" Add a private layer to the private layers dictionary.
"
function! s:private_layer(layer_name)
  call s:debug('--> User added private layer ' . a:layer_name)
  if index(g:dotspaceneovim_configuration_private_layers, a:layer_name) ==? -1
    call add(g:dotspaceneovim_configuration_private_layers, a:layer_name)
  endif
endfunction

""
" Add a plugin to the plugins dictionary.
"
function! s:extra_plugin(plugin_name, ...)
  let l:plugin_config = get(a:, '1', {})
  call s:debug('--> User added extra plugin ' . a:plugin_name)
  if index(g:dotspaceneovim_additional_plugins, a:plugin_name) ==? -1
    call add(g:dotspaceneovim_additional_plugins, {'name': a:plugin_name, 'config': l:plugin_config})
  endif
endfunction

""
" Get the leader key.
"
function! spaceneovim#get_leader_key()
  return g:dotspaceneovim_leader_key
endfunction

""
" Overwrite the default leader key.
"
function! spaceneovim#set_leader_key(new_leader)
  let g:dotspaceneovim_leader_key = a:new_leader
endfunction

""
" Set up the theme, and additionally set an airline theme if 3rd argument is
" provided.
"
function! s:set_theme(theme_background, theme_name, ...)
  try
    if a:theme_background ==? 'light'
      set background=light
    else
      set background=dark
    endif
    if (has('termguicolors'))
      set termguicolors
    endif
    execute 'colorscheme ' . a:theme_name
    hi Comment cterm=italic
    if a:0 ==? 1
      let g:airline_theme=a:1
    endif
  catch
  endtry
endfunction

""
" Enable debugging output.
"
function! s:enable_debugging()
  let g:dotspaceneovim_debug = 1
endfunction

""
" Set the layers repository URL.
"
function! s:set_layer_repo(layer_repo)
  let g:spaceneovim_layers_repository = a:layer_repo
endfunction
