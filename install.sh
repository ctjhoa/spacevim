#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/nvim"
CONFIG_FILE="$HOME/.config/nvim/init.vim"
AUTOLOAD_DIR="$HOME/.config/nvim/autoload"
AUTOLOAD_FILE="$HOME/.config/nvim/autoload/spaceneovim.vim"
CACHE_DIR="$HOME/.cache/nvim"

# Backup exisiting configuration.
if [ -d "$CONFIG_DIR" ]; then
  backup_time=$(date +'%Y-%m-%d.%H-%M-%S')
  mv "$CONFIG_DIR" "$CONFIG_DIR.$backup_time.backup"
fi

# Create the neccessary directories, download the configuration files and launch
# Neovim.
mkdir -p "$CONFIG_DIR" \
  && mkdir -p "$CACHE_DIR" \
  && echo ">>> Downloading configuration file" \
  && curl -sSfL https://raw.githubusercontent.com/tehnix/spaceneovim/master/vimrc.sample.vim -o "$CONFIG_FILE" \
  && echo ">>> Creating autoload directory for spaceneovim" \
  && mkdir -p "$AUTOLOAD_DIR" \
  && echo ">>> Downloading spaceneovim core" \
  && curl -sSfL https://raw.githubusercontent.com/tehnix/spaceneovim/master/autoload/spaceneovim.vim -o "$AUTOLOAD_FILE" \
  && echo ">>> Launching nvim" \
  && nvim \
  && echo ">>> DONE!"
