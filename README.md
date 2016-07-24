# Spacevim - Spacemacs for vim

Spacevim is [Spacemacs](https://github.com/syl20bnr/spacemacs) for vim.
It can be used as a full distribution or you can get only the Spacemacs key bindings

![screenshot](screenshot.png)
[colorscheme](https://github.com/ctjhoa/miro8)

## Installation

Spacevim provides 2 ways of using it. First you can use it as a vim distribution like Spacemacs.
Or you can only install it as a set of key bindings and Spacevim will bring out the best of your currently installed plugin.

### Distribution mode

You want a full vim distribution like Spacemacs provides for emacs.
Execute this line of shell, it will download a default `.vimrc` and install
plugins through vim.

```shell
curl -L https://raw.githubusercontent.com/ctjhoa/spacevim/master/vimrc.sample -o ~/.vimrc | vim
```

After plugins installation restart vim.

### Manual

You already have a vim config and/or want to handle your plugins yourself.
Install Spacevim as usual:

* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/ctjhoa/spacevim ~/.vim/bundle/spacevim`
  * Remember to run `:Helptags` to generate help tags
* [NeoBundle](https://github.com/Shougo/neobundle.vim)
  * `NeoBundle 'ctjhoa/spacevim'`
* [Vundle](https://github.com/gmarik/vundle)
  * `Plugin 'ctjhoa/spacevim'`
* [Plug](https://github.com/junegunn/vim-plug)
  * `Plug 'ctjhoa/spacevim'`
* manual
  * copy all of the files into your `~/.vim` directory

## Plugins

Spacevim relies on several other vim plugins for the key bindings implementations and Spacemacs behavior.

### Key bindings plugins

<table>
  <tr>
    <th>Layer</th>
    <th>Plugin</th>
    <th>Supported alternatives</th>
  </tr>
  <tr>
    <td>core</td>
    <td>`netrw`</td>
    <td>
      <ul>
        <li>[justinmk/vim-dirvish](https://github.com/justinmk/vim-dirvish)</li>
        <li>[scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>core</td>
    <td>[dbakker/vim-projectroot](https://github.com/dbakker/vim-projectroot)</td>
    <td></td>
  </tr>
  <tr>
    <td>core</td>
    <td>[easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion)</td>
    <td></td>
  </tr>
  <tr>
    <td>core</td>
    <td>
      <ul>
        <li>[junegunn/fzf](https://github.com/junegunn/fzf)</li>
        <li>[junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)</li>
      </ul>
    </td>
    <td>
      <ul>
        <li>[Shougo/unite.vim](https://github.com/Shougo/unite.vim)</li>
        <li>[ctrlpvim/ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>core</td>
    <td>[junegunn/gv.vim](https://github.com/junegunn/gv.vim)</td>
    <td></td>
  </tr>
  <tr>
    <td>core</td>
    <td>[mbbill/undotree](https://github.com/mbbill/undotree)</td>
    <td></td>
  </tr>
  <tr>
    <td>core</td>
    <td>[scrooloose/syntastic](https://github.com/scrooloose/syntastic)</td>
    <td></td>
  </tr>
  <tr>
    <td>core</td>
    <td>[tpope/vim-commentary](https://github.com/tpope/vim-commentary)</td>
    <td></td>
  </tr>
  <tr>
    <td>core</td>
    <td>[tpope/vim-eunuch](https://github.com/tpope/vim-eunuch)</td>
    <td></td>
  </tr>
  <tr>
    <td>git</td>
    <td>[airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter)</td>
    <td></td>
  </tr>
  <tr>
    <td>git</td>
    <td>[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)</td>
    <td></td>
  </tr>
</table>

### Behavior plugins

<table>
  <tr>
    <th>Plugin</th>
  </tr>
  <tr>
    <td>[haya14busa/incsearch.vim](https://github.com/haya14busa/incsearch.vim)</td>
  </tr>
  <tr>
    <td>[hecal3/vim-leader-guide](https://github.com/hecal3/vim-leader-guide)</td>
  </tr>
  <tr>
    <td>[osyo-manga/vim-over](https://github.com/osyo-manga/vim-over)</td>
  </tr>
  <tr>
    <td>[sheerun/vim-polyglot](https://github.com/sheerun/vim-polyglot)</td>
  </tr>
  <tr>
    <td>[tpope/vim-surround](https://github.com/tpope/vim-surround)</td>
  </tr>
  <tr>
    <td>[tpope/vim-vinegar](https://github.com/tpope/vim-vinegar)</td>
  </tr>
  <tr>
    <td>[Raimondi/delimitMate](https://github.com/Raimondi/delimitMate)</td>
  </tr>
</table>
