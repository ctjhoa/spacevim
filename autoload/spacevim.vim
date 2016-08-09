function! spacevim#bootstrap() abort
  " vim-plug automatic installation {{{
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimrc VimEnter * PlugInstall | source $MYVIMRC
  endif
  " }}}

  let l:spacevim_layers = {
        \  'core': [
        \    'dbakker/vim-projectroot',
        \    'easymotion/vim-easymotion',
        \    'editorconfig/editorconfig-vim',
        \    'haya14busa/incsearch.vim',
        \    'hecal3/vim-leader-guide',
        \    'junegunn/fzf',
        \    'junegunn/fzf.vim',
        \    'mbbill/undotree',
        \    'mhinz/vim-startify',
        \    'osyo-manga/vim-over',
        \    'Raimondi/delimitMate',
        \    'sheerun/vim-polyglot',
        \    'tpope/vim-commentary',
        \    'tpope/vim-eunuch',
        \    'tpope/vim-surround',
        \    'tpope/vim-sensible',
        \    'tpope/vim-vinegar'
        \  ],
        \  'syntax-checking': [
        \    'scrooloose/syntastic'
        \  ],
        \  'git': [
        \    'airblade/vim-gitgutter',
        \    'junegunn/gv.vim',
        \    'tpope/vim-fugitive'
        \  ]
        \  }

  if exists('g:dotspacevim_configuration_layers')
    call plug#begin('~/.vim/plugged')
    for layer in g:dotspacevim_configuration_layers
      let l:plugins = get(l:spacevim_layers, layer, [])
      for plugin in plugins
        if !exists('g:dotspacevim_additional_plugins') || index(g:dotspacevim_excluded_plugins, plugin) == -1
          Plug plugin
        endif
      endfor
    endfor
    if exists('g:dotspacevim_additional_plugins')
      for plugin in g:dotspacevim_additional_plugins
        Plug plugin
      endfor
    endif
    Plug 'ctjhoa/spacevim'
    call plug#end()
  endif
endfunction
"
