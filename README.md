# .dotfiles

Your dotfiles are how you personalize your system. These are mine.

This is mainly used inside WSL2, but can be used in any ubuntu/debian operating system.

## Installation

```bash
# install .dotfiles
git clone --recurse-submodules git@github.com:geerteltink/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install

# set zsh as default shell
chsh -s $(which zsh)
```

This will run `install.sh` in each subfolder and install apps and symlink files to your home directory.

zsh will be installed with the powerlevel10k theme. When starting your terminal it will source all `.zsh` files in each subfolder.

When running `./install`, it will self update, update the powerlevel10k submodule and even update the system.

## Windows 10 packages

Some default Windows 10 packages are available as well. You can install these from powershell with `winget`.

```powershell
Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/geerteltink/dotfiles/main/winget-packages.json' -OutFile 'winget-packages.json'
winget import winget-packages.json
```

## Get a better font

Fonts look weird? No problem! Cascadia Code has a PL (Powerline) Glyph version! Go get it at [https://github.com/microsoft/cascadia-code/releases](https://github.com/microsoft/cascadia-code/releases) and change the fontFace in your terminal settings.

```json
"fontFace":  "Cascadia Code PL"
```

## Components

Each subfolder is a component, except for `./bin`. `./bin` wil be added to your path.
Each component can consist of the following:

- `install.sh` to install apps, copy files and creating symlinks.
- `*path.zsh` for zsh `$path` configuration.
- `*.completion.zsh` for zsh command completion.
- `*.zsh` for any other non path or completion related stuff.
