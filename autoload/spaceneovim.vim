" Introduction {{{
  " To follow along in this file, you should start by checking out `spaceneovim#bootstrap()`
  " which is the main bulk of the script and setup process. It roughly does the following:
  "   - Checks for the existence of Python
  "   - Downloads the specificed layer repository (using git)
  "   - Locates all layers and filters it to be only the enabled ones
  "   - Sources each layer to build up a list of vim-plug plugins (by calling the 
  "     `auto-layers.vim` file in the layers directory)
  "   - Sets up vim-plug and installs all the plugins found in the enabled layers
  "   - Checks for changes in enabled layers and runs `spaceneovim#install_vim_plug_plugins()`
  "     again if any changes are detected
  "   - Calls the `g:Spaceneovim_postinstall()` function from `auto-layers.vim`
  " 
  " The function `spaceneovim#init()` simply sets up the user facing API commands, calling
  " internal functions defined in a block at the end of this script. If you want to add 
  " something the user will be able to call, add it to this function as a command.
  " 
  " Any command prefixed with `spaceneovim#` is meant to be exposed for `auto-layers.vim`
  " to use.
" }}}

" Set up path variables {{{
  " The users home directory.
  let s:home_dir = $HOME
  " The config location for neovim or vim.
  if has('nvim')
    let s:config_dir = expand(resolve(s:home_dir . '/.config/nvim'))
  else
    let s:config_dir = expand(resolve(s:home_dir . '/.vim'))
  endif
  " Locations for vim-plug and the primary layers directory (pulled with git).
  let s:vim_plug = expand(resolve(s:config_dir . '/autoload/plug.vim'))
  let s:vim_plugged = expand(resolve(s:config_dir . '/plugged'))
  let s:spaceneovim_layers_dir = expand(resolve(s:config_dir . '/spaceneovim-layers'))
  " Cache location for caching which plugins are loaded.
  let s:cache_dir = expand(resolve(s:home_dir . '/.cache/nvim'))
  let s:cache_loaded_plugins = expand(resolve(s:cache_dir . '/loaded-plugins.vim'))
" }}}

" Internal state {{{
  " All layers added in the init.vim configuration.
  let s:dotspaceneovim_configuration_layers = get(g:, 'dotspaceneovim_configuration_layers', {})
  " Extra plugins added in init.vim configuration.
  let s:dotspaceneovim_additional_plugins = get(g:, 'dotspaceneovim_additional_plugins', [])
  " All enabled VIM plug packages.
  let s:dotspaceneovim_enabled_plug_plugins = get(g:, 'dotspaceneovim_enabled_plug_plugins', [])
" }}}

" Set up configurable variables {{{
  " Let the layer repository be configurable.
  let s:default_repository = 'https://github.com/Tehnix/spaceneovim-layers.git'
  let g:dotspaceneovim_layers_repository = get(g:, 'dotspaceneovim_layers_repository', s:default_repository)
  " Debugging flags.
  let g:dotspaceneovim_debug = get(g:, 'dotspaceneovim_debug', 0)
  let g:dotspaceneovim_verbose_debug = get(g:, 'dotspaceneovim_verbose_debug', 0)
  " Set up the leader key.
  let g:dotspaceneovim_leader_key = get(g:, 'dotspaceneovim_leader_key', '<Space>')
  " Let Spaceneovim know which layer is the core layer (will be loaded first!).
  let g:dotspaceneovim_core_layer = get(g:, 'dotspaceneovim_core_layer', '+core/behavior')
  " A list of layer locations that will be checked.
  let g:dotspaceneovim_layer_sources = get(g:, 'dotspaceneovim_layer_sources', [s:spaceneovim_layers_dir . '/layers/', s:spaceneovim_layers_dir . '/private/'])

  " Configure vim-plugs window location to be a new window in bottom right side.
  let g:plug_window = 'botright new'
" }}}

""
" Set up the commands which will be the API the user interfaces with inside
" their VIM configuration.
"
function! spaceneovim#init()
  command! -nargs=1 -bar Layer              call s:layer(<args>)
  command! -nargs=1 -bar PrivateLayer       call s:private_layer(<args>)
  command! -nargs=+ -bar SourcedLayer       call s:layer_with_source(<args>)
  command! -nargs=+ -bar ExtraPlugin        call s:extra_plugin(<args>)
  command! -nargs=+ -bar SetThemeWithBg     call s:set_theme_with_background(<args>)
  command! -nargs=+ -bar SetTheme           call s:set_theme(<args>)
  command! -nargs=0 -bar EnableDebug        call s:enable_debugging()
  command! -nargs=0 -bar EnableVerboseDebug call s:enable_verbose_debugging()
  command! -nargs=1 -bar SetLayerRepo       call s:set_layer_repo(<args>)
  command! -nargs=0 -bar GetLeader          call spaceneovim#get_leader_key()
  command! -nargs=1 -bar SetLeader          call spaceneovim#set_leader_key(<args>)
  call s:debug('>>> Initializing Spaceneovim')
endfunction

""
" Bootstrap the SpaceNeovim installation.
" 
" NOTE: This is the starting function of Spaceneovim, and everything will be
" called from here.
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

  " Set up layer variables {{{
  let l:spaceneovim_layers = {}
  let g:spaceneovim_enabled_layers = {}
  let l:spaceneovim_plugins = []
  " }}}

  " Go through each layer source.
  for l:layer_source in g:dotspaceneovim_layer_sources
    call s:debug('>>> Locating all layers in ' . l:layer_source . ':')
    " Find what layers exist in the sources.
    let l:spaceneovim_layers[l:layer_source] = spaceneovim#find_all_layers(
      \l:layer_source
    \)
    call s:debug('>>> Filtering all enabled layers')
    " Filter out any layers that hasn't been enabled in the source.
    if has_key(s:dotspaceneovim_configuration_layers, l:layer_source)
      let g:spaceneovim_enabled_layers[l:layer_source] = spaceneovim#filter_enabled_layers(
        \l:spaceneovim_layers[l:layer_source],
        \s:dotspaceneovim_configuration_layers[l:layer_source]
      \)
    else
      let g:spaceneovim_enabled_layers[l:layer_source] = []
    endif
  endfor

  " Load in functionality from the layers repository.
  if filereadable(s:spaceneovim_layers_dir . '/auto-layers.vim')
    execute 'source ' . s:spaceneovim_layers_dir . '/auto-layers.vim'
  endif

  " Only proceed if we have python support (or we are using the Oni GUI).
  if l:python_support ==? 1 || exists('g:gui_oni')
    call spaceneovim#setup_vim_plug()
    call spaceneovim#install_enabled_plugins(
      \g:dotspaceneovim_layer_sources,
      \g:spaceneovim_enabled_layers,
      \s:dotspaceneovim_additional_plugins,
    \)
  endif
  call spaceneovim#detect_plugin_changes()

  call g:Spaceneovim_postinstall()
  call s:debug('>>> Finished SpaceNeovim bootstrap')
endfunction

""
" Debug messages to the console if `g:dotspaceneovim_debug` is set
" to true, e.g. through `EnableDebug` or `EnableVerboseDebug` in your 
" VIM config.
"
function! s:debug(msg)
  if g:dotspaceneovim_debug
    echo a:msg
  endif
endfunction

""
" Debug verbose messages to the console if `g:dotspaceneovim_verbose_debug`
" is set to true, e.g. through `EnableVerboseDebug` in your VIM config.
"
function! s:verbose_debug(msg)
  if g:dotspaceneovim_verbose_debug
    echo a:msg
  endif
endfunction

""
" Check for python or python3 availability.
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
function! spaceneovim#find_all_layers(layer_source) abort
  let l:located_layers = []
  for l:group in split(glob(a:layer_source . '*'), '\n')
    for l:layer in split(glob(l:group . '/*'), '\n')
      " Make sure the layer is not empty/invalid
      if filereadable(l:layer . '/config.vim') || filereadable(l:layer . '/packages.vim')
        let l:layer_name = substitute(l:layer, a:layer_source, '', '')
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
  let l:enabled_layers = []
  for l:configuration_layer in a:configured_layers
    if index(a:located_layers, l:configuration_layer) != -1
      call add(l:enabled_layers, l:configuration_layer)
      call s:debug('    Enabled ' . l:configuration_layer)
    endif
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
  if !isdirectory(s:vim_plugged)
    if writefile([], s:cache_loaded_plugins)
      call s:debug('>>> Overwriting cache file, since no plugins were installed!')
    endif
    call spaceneovim#install_vim_plug_plugins()
  endif
endfunction

""
" Install vim-plug plugins.
"
function! spaceneovim#install_vim_plug_plugins()
  call mkdir(s:vim_plugged, 'p')
  call spaceneovim#write_plugins_to_cache()
  call s:debug('>>> Installing all plugins...')
  if has('nvim')
    let l:install_plug_packages = jobstart(['nvim', '+PlugInstall', '+qall'])
    let l:waiting_for_packages = jobwait([l:install_plug_packages])
  else
    silent execute '!vim +PlugInstall +qall'
  endif
  call s:debug('>>> All plugins installed')
endfunction

""
" Load plugin files.
"
function! spaceneovim#load_layer(layer_dir, layer_name)
  if filereadable(a:layer_dir . a:layer_name . '/func.vim')
    execute 'source ' . a:layer_dir . a:layer_name . '/func.vim'
  endif
  if filereadable(a:layer_dir . a:layer_name . '/packages.vim')
    execute 'source ' . a:layer_dir . a:layer_name . '/packages.vim'
  endif
  if filereadable(a:layer_dir . a:layer_name . '/config.vim')
    execute 'source ' . a:layer_dir . a:layer_name . '/config.vim'
  endif
endfunction

""
" Install plugins from all enabled layers.
"
function! spaceneovim#install_enabled_plugins(layer_sources, enabled_layers, additional_plugins) abort
  call s:debug('>>> Sourcing all layers')
  call plug#begin(s:vim_plugged)

  " Explicitly load the core layer(s) first. The reason to explicitly
  " load them first is because they might be defined in other sources
  " than the primary one.
  call s:debug('>>> Loading core layers')
  for l:layer_source in a:layer_sources
    " NOTE: This check is case-sensitive!
    if index(a:enabled_layers[l:layer_source], g:dotspaceneovim_core_layer) != -1
      call spaceneovim#load_layer(l:layer_source, g:dotspaceneovim_core_layer)
    endif
  endfor

  " Load all the plugins from the layer sources (except the core layer).
  " NOTE: Layers internally call ExtraPlugin.
  call s:debug('>>> Loading remaining layers')
  for l:layer_source in a:layer_sources
    for l:layer_name in a:enabled_layers[l:layer_source]
      " NOTE: Because the earlier check is case sensitive, we also make
      " this case-sensitive, to at least hit *exactly* the same layers.
      if l:layer_name !=# g:dotspaceneovim_core_layer
        call spaceneovim#load_layer(l:layer_source, l:layer_name)
      endif
    endfor
  endfor

  " Install any specified plugins (from layers and init.vim config).
  call s:debug('>>> Installing plugins')
  for l:plugin in a:additional_plugins
    call s:debug('     ' . l:plugin.name)
    Plug l:plugin.name, l:plugin.config
    " Add the plugin name so we later on can detect changes from the cache.
    call add(s:dotspaceneovim_enabled_plug_plugins, l:plugin.name)
  endfor
  call plug#end()
endfunction

""
" Detect if new plugins have been added/removed because of layer changes, then
" initialize the vim-plug install process for the user.
"
function! spaceneovim#detect_plugin_changes()
  " Make sure the cache dir exists.
  if !isdirectory(s:cache_dir)
    call mkdir(s:cache_dir, 'p')
  endif
  " Load the list of previously loaded plugins.
  if filereadable(s:cache_loaded_plugins)
    let l:previously_loaded_plugins = readfile(s:cache_loaded_plugins)
  else
    let l:previously_loaded_plugins = []
  endif
  " Check if the plugins have changed. Note that this is ordering sensitive!
  if l:previously_loaded_plugins == s:dotspaceneovim_enabled_plug_plugins
    call s:debug('>>> No changes in plugins')
  else
    call s:debug('>>> Plugins changed, installing new ones')
    call spaceneovim#install_vim_plug_plugins()
  endif
endfunction

""
" Write the enabled plugins to the cache file.
"
function! spaceneovim#write_plugins_to_cache()
  " Make sure the cache dir exists.
  if !isdirectory(s:cache_dir)
    call mkdir(s:cache_dir, 'p')
  endif
  " Update the cache file.
  if writefile(s:dotspaceneovim_enabled_plug_plugins, s:cache_loaded_plugins)
    call s:debug('>>> Could not write loaded plugins to cache file!')
  endif
endfunction

" Functions used by the user facing API {{{
  ""
  " Add a layer to the layers dictionary.
  "
  function! s:layer(layer_name)
    call s:verbose_debug('--> User added layer ' . a:layer_name)
    call s:_layer_with_source(a:layer_name, s:spaceneovim_layers_dir . '/layers/')
  endfunction

  ""
  " Add a private layer to the private layers dictionary.
  "
  function! s:private_layer(layer_name)
    call s:verbose_debug('--> User added private layer ' . a:layer_name)
    call s:_layer_with_source(a:layer_name, s:spaceneovim_layers_dir . '/private/')
  endfunction

  ""
  " Add a layer to a specified source.
  "
  function! s:layer_with_source(layer_name, layer_source)
    " Check if the layer source has been registered.
    call s:verbose_debug('--> User added sourced layer ' . a:layer_source . a:layer_name)
    call s:_layer_with_source(a:layer_name, a:layer_source)
  endfunction

  ""
  " Internal function for adding a layer to an explicit source.
  "
  function! s:_layer_with_source(layer_name, layer_source)
    " Check if the layer source has been registered.
    if !has_key(s:dotspaceneovim_configuration_layers, a:layer_source)
      call s:debug('Creating new container for ' . a:layer_source)
      let s:dotspaceneovim_configuration_layers[a:layer_source] = []
    endif
    " Add the new layer if it doesn't already exist.
    if index(s:dotspaceneovim_configuration_layers[a:layer_source], a:layer_name) ==? -1
      call add(s:dotspaceneovim_configuration_layers[a:layer_source], a:layer_name)
    endif
  endfunction

  ""
  " Add a plugin to the plugins dictionary.
  "
  function! s:_add_plugin(plugin_name, plugin_config)
    if index(s:dotspaceneovim_additional_plugins, a:plugin_name) ==? -1
      call add(s:dotspaceneovim_additional_plugins, {'name': a:plugin_name, 'config': a:plugin_config})
    endif
  endfunction

  function! s:extra_plugin(plugin_name, ...)
    call s:verbose_debug('--> User added extra plugin ' . a:plugin_name)
    let l:plugin_config = get(a:, '1', {})
    call s:_add_plugin(a:plugin_name, l:plugin_config)
  endfunction

  function! spaceneovim#layer_plugin(plugin_name, ...)
    call s:verbose_debug('    Layer added plugin ' . a:plugin_name)
    let l:plugin_config = get(a:, '1', {})
    call s:_add_plugin(a:plugin_name, l:plugin_config)
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
  function! s:set_theme(theme_name, ...)
    try
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

  function! s:set_theme_with_background(theme_background, theme_name, ...)
    if a:theme_background ==? 'light'
      set background=light
    else
      set background=dark
    endif
    if a:0 ==? 1
      call s:set_theme(a:theme_name, a:1)
    else
      call s:set_theme(a:theme_name)
    endif
  endfunction

  ""
  " Enable debugging output.
  "
  function! s:enable_debugging()
    let g:dotspaceneovim_debug = 1
  endfunction

  ""
  " Enable debugging output.
  "
  function! s:enable_verbose_debugging()
    let g:dotspaceneovim_verbose_debug = 1
  endfunction

  ""
  " Set the layers repository URL.
  "
  function! s:set_layer_repo(layer_repo)
    let g:spaceneovim_layers_repository = a:layer_repo
  endfunction
" }}}
