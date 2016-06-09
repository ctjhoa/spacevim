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

## Optimal spacemacs config
Spacevim relies on several other vim plugins for the key bindings implementations.
So every plugin is only needed to execute mapped action but to get the best experience recommended plugins are:

- [hecal3/vim-leader-guide](https://github.com/hecal3/vim-leader-guide)
- [junegunn/fzf](https://github.com/junegunn/fzf)
- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [tpope/vim-commentary](https://github.com/tpope/vim-commentary)
- [tpope/vim-eunuch](https://github.com/tpope/vim-eunuch)
- [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)

## Also supported plugins
Some of the recommended plugins could be replaced by alternatives.

Alternative to [junegunn/fzf](https://github.com/junegunn/fzf) & [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
- [Shougo/unite.vim](https://github.com/Shougo/unite.vim)
- [ctrlpvim/ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)
