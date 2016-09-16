# SpaceNeovim - Spacemacs for Neovim [![Build Status](https://travis-ci.org/ctjhoa/SpaceNeovim.svg?branch=master)](https://travis-ci.org/tehnix/spaceneovim)

SpaceNeovim is [Spacemacs](https://github.com/syl20bnr/spacemacs) for vim.

Startup screen | Vim-leader-guide in action
:-------------:|:--------------------------:
![screenshot1](assets/screeshot-startify-2.0.0.png) | ![screenshot2](assets/screeshot-leader-2.0.0.png)


## Installation

__Prerequisites:__
* `git` on your path
* `nvim` on your path

SpaceNeovim is a configurable distribution like Spacemacs.

To start using SpaceNeovim you can use the following oneliner,

```shell
mkdir -p ~/.config/nvim/ && curl -sSfL https://raw.githubusercontent.com/tehnix/spaceneovim/master/vimrc.sample -o ~/.config/nvim/init.vim | nvim
```

It will download a default `init.vim` which in turn takes care of setting up the
rest by:

* Downloading `autoload/spacevim.vim`
* Setting up [vim-plug](https://github.com/junegunn/vim-plug)
* Cloning down the [layers repository](https://github.com/Tehnix/spaceneovim-layers)
* Installing default plugins


## Layers

Go to the [layers repository](https://github.com/Tehnix/spaceneovim-layers) for
more information on the different layers.

To enable a layer, include it in `g:dotspacevim_configuration_layers` inside the `dotspacevim/init` block. For example, the following enables the `+checkers/syntax-checking` layer,

```viml
let g:dotspacevim_configuration_layers = [
\  '+checkers/syntax-checking'
\]
```

You can also add custom layers to `g:dotspacevim_additional_plugins`, which will be installed with `vim-plug`.


## License

See [LICENSE](LICENSE).
