#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

case "$(uname -m)" in
  x86_64)      assets=("nvim-linux-x86_64.tar.gz" "nvim-linux64.tar.gz") ;;
  aarch64|arm64) assets=("nvim-linux-arm64.tar.gz" "nvim-linux-arm64.zip") ;;
  *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

curl -fsSL -o "$tmp/latest.json" https://api.github.com/repos/neovim/neovim/releases/latest
links=$(grep -oE 'https://github.com/neovim/neovim/releases/download/[^"]+' "$tmp/latest.json")
url=""
for asset in "${assets[@]}"; do
  url=$(grep -F "$asset" <<<"$links" | head -n1) || true
  [ -n "$url" ] && break
done
[ -n "$url" ] || { echo "release asset not found for $(uname -m)" >&2; exit 1; }

echo "fetching: $url"
curl -fsSL -o "$tmp/dl" "$url"

case "$asset" in
  *.tar.gz) tar -xzf "$tmp/dl" -C "$tmp" ;;
  *.zip)    unzip -oq  "$tmp/dl" -d "$tmp" ;;
esac

nvim_bin=$(find "$tmp" -type f -name nvim | head -n1)
[ -n "$nvim_bin" ] || { echo "nvim binary not found in release" >&2; exit 1; }
mv "$nvim_bin" "$BIN_DIR/nvim"
chmod +x "$BIN_DIR/nvim"
echo "installed: $("$BIN_DIR/nvim" --version | head -n1)"
