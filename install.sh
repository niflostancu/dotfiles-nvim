#!/bin/bash
# My NeoVim dotfiles installation script
# Actually installs a wrapper script to the XDG_CONFIG_HOME/nvim directory that
# points to the actual configuration repository (external path).

SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NVIM_CONFIG_DEST="${XDG_CONFIG_HOME:-$HOME/.config}/${NVIM_APPNAME:-nvim}"

if [[ -f "$NVIM_CONFIG_DEST/config.lua" ]]; then
  echo "A nvim configuration already exists in $NVIM_CONFIG_DEST!"
  read -p "Are you sure you want to replace it? " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

echo "Installing vim config to '$NVIM_CONFIG_DEST'"

mkdir -p "$NVIM_CONFIG_DEST"
cp -f "$SRC_DIR/misc/init-template.lua" "$NVIM_CONFIG_DEST/init.lua"
sed -i 's|<MYCONFIGPATH>|'"$SRC_DIR"'|' "$NVIM_CONFIG_DEST/init.lua"
cp -rf "$SRC_DIR/misc/lua" "$NVIM_CONFIG_DEST/"

echo "Done!"

