# .dotfiles

Your dotfiles are how you personalize your system. These are mine.

This is mainly used inside WSL2, but can be used in any ubuntu/debian operating system.

## Setup WSL2

You can install everything you need to run Windows Subsystem for Linux (WSL).

First, enable the virtual machine platform.

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all
```

Next, install WSL via the windows store https://aka.ms/wslstorepage, or via powershell.

```powershell
wsl --install
```

Restart your machine and set the default WSL version and install a distribution.

```powershell
wsl --set-default-version 2
wsl --list --online
wsl --install -d Ubuntu
```

Next up install some tools from the windows store to get started.

- https://aka.ms/terminal
- https://aka.ms/vscode

## Installation Ubuntu

```bash
# install .dotfiles
git clone https://github.com/geerteltink/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

This will run `install.sh` in each subfolder and install apps and symlink files to your home directory.

When running `./install`, it will self update and update the system.

### Local export variables

Local variables can be added as an export in `~/.bash_env`.

### Switching PHP versions

```bash
sudo update-alternatives --config php
```

## Installation PowerShell

Some default Windows 10 packages are available as well. You can install these from powershell with `winget`.
[winget-cli](https://github.com/microsoft/winget-cli#readme) is installed by default since 21H1.

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

## zsh Tips & Tricks

```text
Arrow up    - search history backward
Arrow down  - search history forward
Arrow left  - jump to start of previous word
Arrow right - jump to start of next word

Ctrl + U    – delete from the cursor to the start of the line
Ctrl + K    – delete from the cursor to the end of the line
Ctrl + W    – delete from the cursor to the start of the preceding word
Alt + D     – delete from the cursor to the end of the next word
Ctrl + L    – clear the terminal

z <insert favorite directory>
../subdir   - change to subdirectory of parent
```
