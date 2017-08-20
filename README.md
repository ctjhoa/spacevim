# SpaceNeovim - Spacemacs for Neovim [![Build Status](https://travis-ci.org/Tehnix/spaceneovim.svg?branch=master)](https://travis-ci.org/Tehnix/spaceneovim)

SpaceNeovim is [Spacemacs](https://github.com/syl20bnr/spacemacs) for Neovim. If you are unfamiliar with Spacemacs, you can read more about the motivation behind that on their website.

![Screenshot of SpaceNeovim](assets/Screenshot%202017-08-21%2003.46.23.png)

## Installation

Prerequisites:

- `git` on your path (`brew install git`)
- `nvim` on your path (`brew install neovim/neovim --head`)
- Neovim python bindings (`pip install neovim` or `pip3`)

SpaceNeovim is a configurable distribution like Spacemacs.

To start using SpaceNeovim you can use the following oneliner,

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tehnix/spaceneovim/master/install.sh)"
```

It will,

- Backup existing Neovim configuration to `.config/nvim.<date>.backup`
- Download a default `init.vim`
- Download `autoload/spaceneovim.vim`
- Set up [vim-plug](https://github.com/junegunn/vim-plug)
- Clone down the [layers repository](https://github.com/Tehnix/spaceneovim-layers)
- Install default plugins

## Layers

Go to the [layers repository](https://github.com/Tehnix/spaceneovim-layers) for more information on the different layers.

To enable a layer, include it inside the `Layers()` function, by calling `Layer '<layer name>'`. A small example,

```viml
function! Layers()
  " Configuration Layers declaration.
  " Add layers with `Layer '+layername'` and add individual packages
  " with `ExtraPlugin 'githubUser/Repo'`.

  Layer '+core/behavior'
  Layer '+nav/buffers'
  Layer ...

  ExtraPlugin 'liuchengxu/space-vim-dark'
  ExtraPlugin 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
endfunction
```

The above also demonstrates `ExtraPlugin`, which will install plugins with `vim-plug`.

## Configuration

To set configuration values **before** layers and plugins load, set them in your `UserInit()`,

```viml
function! UserInit()
  " This block is called at the very startup of Spaceneovim initialization
  " before layers configuration.

  SetLayerRepo 'git@github.com:Tehnix/spaceneovim-layers.git'
endfunction
```

To set configuration values **after** layers and plugins load, set them in your `UserConfig()`,

```viml
function! UserConfig()
  " This block is called after Spaceneovim layers are configured.

  SetTheme 'dark', 'space-vim-dark', 'violet'
endfunction
```

The above `SetTheme <background color> <theme name> <airline theme>` is simply a convenience function.

## Developing

To easily test your changes it is recommended to symlink the various files into your `.config/nvim` folder. The ones you want to replace are

- `.config/nvim/spaceneovim-layers` to test layer changes
- `.config/nvim/autoload/spaceneovim.vim` to test core changes
- `.config/nvim/init.vim` to test changes to `vimrc.sample.vim`

### Using your own layer repository

If you want to develop/test out your own layers, there are two ways to do it:

1. Point to your own git repository with `SetLayerRepo`, e.g. `SetLayerRepo 'git@github.com:Tehnix/spaceneovim-layers.git'`. This should be set in `UserInit()`.
2. Manage the `spaceneovim-layers` directory yourself - the bootstrap process basically just checks if the directory exists, and if not it clones it down. Symlinking or putting in your own directory here will also work.

### Enable Debugging

You can enable debugging output by calling `EnableDebug` in your `init.vim` file. This should be set in `UserInit()`.

## License

See

<license>.</license>

## Troubleshooting

**Can't see colors in tmux:** This may be a problem with xterm-256 colors, as per issue #16 (thanks zacacollier) add the following your `tmux.conf` and restert your tmux with `tmux kill-server`,

```
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ',xterm-256color:Tc'
```
