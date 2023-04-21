#!/bin/bash
# LunarVim-based dotfiles installation script

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/lvim/"

if [[ -f "$LVIM_CONFIG/config.lua" ]]; then
  echo "A lvim configuration already exists in $LVIM_CONFIG!"
  read -p "Are you sure you want to replace it? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

echo "Installing vim config to '$LVIM_CONFIG'"

mkdir -p "$LVIM_CONFIG"
cp -f "$SRC_DIR/misc/config-template.lua" "$LVIM_CONFIG/config.lua"

echo "Done!"

