function! spacevim#bootstrap() abort

  let g:spacevim_layers = [
  \ { 'name': 'core', 'alias': 'core/_' },
  \ { 'name': 'core/applications' },
  \ { 'name': 'core/behavior' },
  \ { 'name': 'core/buffers', 'alias': 'core/buffers/_' },
  \ { 'name': 'core/buffers/move' },
  \ { 'name': 'core/compile-comments' },
  \ { 'name': 'core/capture-colors' },
  \ { 'name': 'core/files', 'alias': 'core/files/_' },
  \ { 'name': 'core/files/convert' },
  \ { 'name': 'core/files/vim' },
  \ { 'name': 'core/help-highlight' },
  \ { 'name': 'core/insertion' },
  \ { 'name': 'core/join-split' },
  \ { 'name': 'core/lisp' },
  \ { 'name': 'core/narrow-numbers' },
  \ { 'name': 'core/projects' },
  \ { 'name': 'core/quit' },
  \ { 'name': 'core/registers-rings' },
  \ { 'name': 'core/search-symbol' },
  \ { 'name': 'core/toggles', 'alias': 'core/toggles/_' },
  \ { 'name': 'core/toggles/highlight' },
  \ { 'name': 'core/toggles/colors' },
  \ { 'name': 'core/ui-toggles-themes' },
  \ { 'name': 'core/windows' },
  \ { 'name': 'core/text' },
  \ { 'name': 'core/zoom' },
  \ { 'name': 'git', 'alias': 'git/_' },
  \ { 'name': 'git/vcs-micro-state' },
  \ { 'name': 'syntax-checking' },
  \ ]

  let g:spacevim_enabled_layers = []

  if exists('g:dotspacevim_configuration_layers')
    for configuration_layer in g:dotspacevim_configuration_layers
      for layer in g:spacevim_layers
        if layer.name =~ configuration_layer || get(layer, 'alias', '') =~ configuration_layer
          call add(g:spacevim_enabled_layers, layer.name)
        endif
      endfor
    endfor
  else
    let g:spacevim_enabled_layers = map(g:spacevim_layers, 'v:val.name')
  endif

  if exists('g:dotspacevim_distribution_mode') && g:dotspacevim_distribution_mode

    " Default plugins in distribution mode
    let g:spacevim_plugins = [
    \ { 'name': 'Raimondi/delimitMate',           'layers': ['core/behavior'] },
    \ { 'name': 'airblade/vim-gitgutter',         'layers': ['git', 'git/vcs-micro-state'] },
    \ { 'name': 'dbakker/vim-projectroot',        'layers': ['core/projects'] },
    \ { 'name': 'easymotion/vim-easymotion',      'layers': ['core'] },
    \ { 'name': 'haya14busa/incsearch.vim',       'layers': ['core/behavior'] },
    \ { 'name': 'hecal3/vim-leader-guide',        'layers': ['core/behavior'] },
    \ { 'name': 'junegunn/fzf',                   'layers': ['core/buffers', 'core/files', 'core/projects', 'core'] },
    \ { 'name': 'junegunn/fzf.vim',               'layers': ['core/buffers', 'core/files', 'core/projects', 'core'] },
    \ { 'name': 'junegunn/gv.vim',                'layers': ['git'] },
    \ { 'name': 'kana/vim-arpeggio',              'layers': ['core/behavior'] },
    \ { 'name': 'Konfekt/vim-alias',              'layers': ['core/behavior'] },
    \ { 'name': 'mbbill/undotree',                'layers': ['core/applications'] },
    \ { 'name': 'mhinz/vim-startify',             'layers': ['core/behavior'] },
    \ { 'name': 'osyo-manga/vim-over',            'layers': ['core/behavior'] },
    \ { 'name': 'pelodelfuego/vim-swoop',         'layers': ['core/search-symbol'] },
    \ { 'name': 'scrooloose/syntastic',           'layers': ['syntax-checking'] },
    \ { 'name': 'sheerun/vim-polyglot',           'layers': ['core/behavior'] },
    \ { 'name': 'tpope/vim-commentary',           'layers': ['core'] },
    \ { 'name': 'tpope/vim-eunuch',               'layers': ['core/files'] },
    \ { 'name': 'tpope/vim-fugitive',             'layers': ['git'] },
    \ { 'name': 'tpope/vim-sensible',             'layers': ['core/behavior'] },
    \ { 'name': 'tpope/vim-surround',             'layers': ['core/behavior'] },
    \ { 'name': 'tpope/vim-vinegar',              'layers': ['core/files', 'core/projects'] }
    \ ]

    " vim-plug automatic installation {{{
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -sSfLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      augroup spacevim_bootstrap
        autocmd!
        autocmd VimEnter * PlugInstall | source $MYVIMRC
      augroup END
    endif
    " }}}

    " plugins installation {{{
    call plug#begin('~/.vim/plugged')
    Plug 'ctjhoa/spacevim'
    for layer in g:spacevim_enabled_layers
      for plugin in g:spacevim_plugins
        if index(plugin.layers, layer) != -1 &&
        \ (!exists('g:dotspacevim_excluded_plugins') || index(g:dotspacevim_excluded_plugins, plugin) == -1)
          Plug plugin.name
        endif
      endfor
    endfor
    if exists('g:dotspacevim_additional_plugins')
      for additional_plugin in g:dotspacevim_additional_plugins
        Plug additional_plugin
      endfor
    endif
    call plug#end()
    " }}}
  endif
endfunction
"
