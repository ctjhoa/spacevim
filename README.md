# Spacevim
*Spacemacs key bindings for vim*

Spacevim provides leader bindings to match most of [Spacemacs](https://github.com/syl20bnr/spacemacs) behaviour.

![screenshot](screenshot.png)
[colorscheme](https://github.com/ctjhoa/miro8)

##  Installation
This plugin follows the standard runtime path structure, and as such it can be installed with a variety of plugin managers:

*  [Pathogen](https://github.com/tpope/vim-pathogen)
  *  `git clone https://github.com/ctjhoa/spacevim ~/.vim/bundle/spacevim`
  *  Remember to run `:Helptags` to generate help tags
*  [NeoBundle](https://github.com/Shougo/neobundle.vim)
  *  `NeoBundle 'ctjhoa/spacevim'`
*  [Vundle](https://github.com/gmarik/vundle)
  *  `Plugin 'ctjhoa/spacevim'`
*  [Plug](https://github.com/junegunn/vim-plug)
  *  `Plug 'ctjhoa/spacevim'`
*  manual
  *  copy all of the files into your `~/.vim` directory

## Requirements
Spacevim relies on several other vim plugins for the key bindings implementations and spacemacs behavior.

### Mapping plugins
So every plugin in this list is only needed to execute mapped action but to get the best experience recommended plugins are:

- [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter)
- [dbakker/vim-projectroot](https://github.com/dbakker/vim-projectroot)
- [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [junegunn/gv.vim](https://github.com/junegunn/gv.vim)
- [mbbill/undotree](https://github.com/mbbill/undotree)
- [scrooloose/syntastic](https://github.com/scrooloose/syntastic)
- [tpope/vim-commentary](https://github.com/tpope/vim-commentary)
- [tpope/vim-eunuch](https://github.com/tpope/vim-eunuch)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)

Some of the recommended plugins could be replaced by alternatives.

Alternative to [junegunn/fzf](https://github.com/junegunn/fzf) & [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [Shougo/unite.vim](https://github.com/Shougo/unite.vim)
- [ctrlpvim/ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)

`netrw` is recommended as it's the built-in vim explorer but the following plugins are supported to:
- [justinmk/vim-dirvish](https://github.com/justinmk/vim-dirvish)
- [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)

### Behavior plugins
To be the closest to the spacemacs behavior the folowing plugins are recommended:

- [haya14busa/incsearch.vim](https://github.com/haya14busa/incsearch.vim)
- [hecal3/vim-leader-guide](https://github.com/hecal3/vim-leader-guide)
- [osyo-manga/vim-over](https://github.com/osyo-manga/vim-over)
- [tpope/vim-surround](https://github.com/tpope/vim-surround)
- [Raimondi/delimitMate](https://github.com/Raimondi/delimitMate)
