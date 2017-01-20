function! spacevim#bootstrap() abort

  let g:spacevim_layers = [
  \ 'core/root',
  \ 'core/applications',
  \ 'core/behavior',
  \ 'core/buffers',
  \ 'core/buffers/move',
  \ 'core/compile-comments',
  \ 'core/capture-colors',
  \ 'core/files',
  \ 'core/files/convert',
  \ 'core/files/vim',
  \ 'core/help-highlight',
  \ 'core/insertion',
  \ 'core/join-split',
  \ 'core/lisp',
  \ 'core/narrow-numbers',
  \ 'core/projects',
  \ 'core/quit',
  \ 'core/registers-rings',
  \ 'core/search-symbol',
  \ 'core/toggles',
  \ 'core/toggles/highlight',
  \ 'core/toggles/colors',
  \ 'core/ui-toggles-themes',
  \ 'core/windows',
  \ 'core/text',
  \ 'core/zoom',
  \ 'git',
  \ 'git/vcs-micro-state',
  \ 'syntax-checking',
  \ ]

  let g:spacevim_enabled_layers = []

  if exists('g:dotspacevim_configuration_layers')
    for configuration_layer in g:dotspacevim_configuration_layers
      for layer in g:spacevim_layers
        if layer =~ configuration_layer
          call add(g:spacevim_enabled_layers, layer)
        endif
      endfor
    endfor
  else
    let g:spacevim_enabled_layers = g:spacevim_layers
  endif

  if exists('g:dotspacevim_distribution_mode') && g:dotspacevim_distribution_mode

    let g:spacevim_plugins = [
    \ { 'name': 'airblade/vim-gitgutter',         'layers': ['git'] },
    \ { 'name': 'dbakker/vim-projectroot',        'layers': ['core/projects'] },
    \ { 'name': 'easymotion/vim-easymotion',      'layers': ['core/root'] },
    \ { 'name': 'editorconfig/editorconfig-vim',  'layers': ['core/behavior'] },
    \ { 'name': 'haya14busa/incsearch.vim',       'layers': ['core/behavior'] },
    \ { 'name': 'hecal3/vim-leader-guide',        'layers': ['core/behavior'] },
    \ { 'name': 'junegunn/fzf',                   'layers': ['core/buffers', 'core/files', 'core/projects', 'core/root'] },
    \ { 'name': 'junegunn/fzf.vim',               'layers': ['core/buffers', 'core/files', 'core/projects', 'core/root'] },
    \ { 'name': 'junegunn/gv.vim',                'layers': ['git'] },
    \ { 'name': 'kana/vim-arpeggio',              'layers': ['core/behavior'] },
    \ { 'name': 'mbbill/undotree',                'layers': ['core/applications'] },
    \ { 'name': 'mhinz/vim-startify',             'layers': ['core/behavior'] },
    \ { 'name': 'osyo-manga/vim-over',            'layers': ['core/behavior'] },
    \ { 'name': 'pelodelfuego/vim-swoop',         'layers': ['core/search-symbol'] },
    \ { 'name': 'Raimondi/delimitMate',           'layers': ['core/behavior'] },
    \ { 'name': 'scrooloose/syntastic',           'layers': ['syntax-checking'] },
    \ { 'name': 'sheerun/vim-polyglot',           'layers': ['core/behavior'] },
    \ { 'name': 'tpope/vim-commentary',           'layers': ['core/root'] },
    \ { 'name': 'tpope/vim-eunuch',               'layers': ['core/files'] },
    \ { 'name': 'tpope/vim-fugitive',             'layers': ['git'] },
    \ { 'name': 'tpope/vim-surround',             'layers': ['core/behavior'] },
    \ { 'name': 'tpope/vim-sensible',             'layers': ['core/behavior'] },
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
          if plugin.name ==# 'hecal3/vim-leader-guide'
            Plug plugin.name, { 'commit': 'bade1b9dfc5e56aaf322791fff11e350fd8681ae' }
          else
            Plug plugin.name
          endif
        endif
      endfor
    endfor
    if exists('g:dotspacevim_additional_plugins')
      for additional_plugin in g:dotspacevim_additional_plugins
        if type(additional_plugin) == type({})
          Plug additional_plugin.name, additional_plugin.option
        else
          Plug additional_plugin
        endif
      endfor
    endif
    call plug#end()
    " }}}
  endif
endfunction
"
