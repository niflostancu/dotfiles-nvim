# Neovim dotfiles (based on AstroNvim)

My personal NeoVim LUA configurations based on [AstroNvim](https://github.com/AstroNvim/AstroNvim)

**NOTE:** Requires AstroNvim v6+ and Neovim `>=0.11`.

## Features

- **Pimped UI**: [AstroDark](https://github.com/AstroNvim/astrotheme) + [Neovide](https://neovide.dev/) integration, dashboard etc.;
- **Tab-centric workflow**: I use tabs for working on different project-related components (each in their own CWDs);
- [**Lazy.nvim**](https://github.com/folke/lazy.nvim)-based plugins with own LUA organization: configuration split by plugin category + one for each programming language; 
- [**CodeCompanion**](https://codecompanion.olimorris.dev/)-based local LLM integration;
- Custom setup for multi-nvim instancing like ShaDa sharing, remote instance control, remote sshfs etc.;
- Many other personalizations for the base AstroNVim components (`Snacks.picker`, `neo-tree`, `resession` etc.);

## Installation

The usual instructions from AstroNvim:

Either clone this repository directly to `~/.config/nvim` (or any other `~/.config/` directory and specify `NVIM_APPNAME`):

```sh
git clone https://github.com/niflostancu/dotfiles-nvim ~/.config/<your-name>
NVIM_APPNAME="<your-name>" nvim
```

... or clone it somewhere else (.e.g, your config documents) and use the `install.sh` script:

```sh
cd ~/Documents/Configs
git clone https://github.com/niflostancu/dotfiles-nvim
cd dotfiles-nvim && ./install.sh
```

## Key Mappings

The [which-key](https://github.com/folke/which-key.nvim) shows further shortcuts as a bottom menu:

- `<C-s>` for saving in all modes;
- `g<1-9>`, `H` and `L` to switch between tabs;
- `<Leader>` is **Space**;
- `<Leader>g` prefix for git commands;
- `<Leader>u` prefix for UI management;
- `<Leader>S` prefix for session management;
- `<F3>` to toggle file explorer;
- `;` prefix for picker (finder) commands;
- `;f` to find files;
- `;g` to grep files;
- `;a` to show current file in explorer;
- `;i` to toggle CodeCompanion AI chat panel;
etc.
