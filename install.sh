#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/nvim"
CONFIG_FILE="$HOME/.config/nvim/init.vim"
AUTOLOAD_DIR="$HOME/.config/nvim/autoload"
AUTOLOAD_FILE="$HOME/.config/nvim/autoload/spaceneovim.vim"

# Backup exisiting configuration.
if [ -d "$CONFIG_DIR" ]; then
  backup_time=$(date +'%Y-%m-%d.%H-%M-%S')
  mv "$CONFIG_DIR" "$CONFIG_DIR.$backup_time.backup"
fi

# Create the neccessary directories, download the configuration files and launch
# Neovim.
mkdir -p "$CONFIG_DIR" \
  && curl -sSfL https://raw.githubusercontent.com/tehnix/spaceneovim/master/vimrc.sample.vim -o "$CONFIG_FILE" \
  && mkdir -p "$AUTOLOAD_DIR" \
  && curl -sSfL https://raw.githubusercontent.com/tehnix/spaceneovim/master/autoload/spaceneovim.vim -o "$AUTOLOAD_FILE" \
  && nvim
