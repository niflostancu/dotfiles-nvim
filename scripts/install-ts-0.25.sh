#!/bin/bash

curl -fsSL -o /tmp/tree-sitter.gz \
	https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.10/tree-sitter-linux-x64.gz
gunzip -c /tmp/tree-sitter.gz > ~/.local/bin/tree-sitter
chmod +x ~/.local/bin/tree-sitter
tree-sitter --version   # → tree-sitter 0.25.10

