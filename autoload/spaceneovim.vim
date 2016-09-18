" Set up path variables {{{
let s:config_dir = $HOME . '/.config/nvim'
let s:vim_plug = expand(resolve(s:config_dir . '/autoload/plug.vim'))
let s:vim_plugged = expand(resolve(s:config_dir . '/plugged'))
let s:spaceneovim_layers_dir = expand(resolve(s:config_dir . '/spaceneovim-layers'))
" }}}

function! spaceneovim#bootstrap() abort
  " Download the layers {{{
  if empty(glob(s:spaceneovim_layers_dir))
    let l:layers_repo = 'git@github.com:Tehnix/spaceneovim-layers.git'
    if exists('g:spaceneovim_layers_repository')
      let l:layers_repo = g:spaceneovim_layers_repository
    endif
    let l:install_layers = jobstart([
    \  'git'
    \, 'clone'
    \, l:layers_repo
    \, s:spaceneovim_layers_dir
    \])
    let l:waiting_for_layers = jobwait([l:install_layers])
  endif
  " }}}

  " Add the layers to g:spaceneovim_layers {{{
  let g:spaceneovim_layers = []

  if filereadable(s:spaceneovim_layers_dir . '/auto-layers.vim')
    execute 'source ' . s:spaceneovim_layers_dir . '/auto-layers.vim'
  endif
  " }}}

  " Add all valid layers to enabled layers {{{
  let g:spaceneovim_enabled_layers = []

  if exists('g:dotspaceneovim_configuration_layers')
    for l:configuration_layer in g:dotspaceneovim_configuration_layers
      for l:layer in g:spaceneovim_layers
        if l:layer =~ l:configuration_layer
          call add(g:spaceneovim_enabled_layers, l:layer)
        endif
      endfor
    endfor
  endif
  " }}}

  " Setup and install vim-plug {{{
  if empty(glob(s:vim_plug))
    let l:install_plug = jobstart([
    \  'curl'
    \, '-fLo'
    \, s:vim_plug
    \, '--create-dirs'
    \, 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    \])
    let l:waiting_for_plug = jobwait([l:install_plug])
    let l:install_plug_packages = jobstart(['nvim', '+PlugInstall', '+qall'])
    let l:waiting_for_packages = jobwait([l:install_plug_packages])
    source $MYVIMRC
  endif
  " }}}

  " Install all plugins from enabled layers {{{
  call plug#begin(s:vim_plugged)
  Plug 'hecal3/vim-leader-guide'
  let g:spaceneovim_plugins = []
  for l:layer in g:spaceneovim_enabled_layers
    execute 'source ' . s:spaceneovim_layers_dir . '/layers/' . l:layer . '/packages.vim'
    execute 'source ' . s:spaceneovim_layers_dir . '/layers/' . l:layer . '/config.vim'
  endfor

  for l:plugin in g:spaceneovim_plugins
    Plug l:plugin.name, l:plugin.config
  endfor

  if exists('g:dotspaceneovim_additional_packages')
    for l:additional_plugin in g:dotspaceneovim_additional_packages
      Plug l:additional_plugin.name, l:additional_plugin.config
    endfor
  endif
  call plug#end()
  " }}}
endfunction
